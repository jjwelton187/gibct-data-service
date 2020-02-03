# frozen_string_literal: true

require 'faraday'
require 'common/client/errors'

require 'common/exceptions/external/backend_service_exception'

module Common
  module Client
    ##
    # Raised if the Faraday adapter is a Faraday::Adapter::HTTPClient and the
    # Common::Client::Middleware::Request::RemoveCookies middleware in not included.
    #
    class SecurityError < StandardError
    end

    ##
    # Base class for creating HTTP services. Wraps the Faraday gem and is configured via by passing in a
    # {Common::Client::Configuration::REST} or {Common::Client::Configuration::SOAP} depending on the type
    # of service you're connecting to. Once configured requests are made via the `perform` method.
    #
    # @example Create a service and make a GET request
    #   class MyService < Common::Client::Base
    #     configuration MyConfiguration
    #
    #     def get_resource
    #       perform(:get, '/api/v1/resource')
    #     end
    #   end
    #
    #   service = MyService.new
    #   response = service.get_resource
    #
    # @example a POST request with a body, headers, and Faraday options
    #   def post_resource(json)
    #     headers = { 'Content-Type' => 'application/json' }
    #     options = { timeout: 60 }
    #     response = perform(:post, '/submit', json, headers, options)
    #   end
    #
    class Base
      ##
      # Sets the configuration singleton to use
      #
      def self.configuration(configuration = nil)
        @configuration ||= configuration.instance
      end

      private

      def config
        self.class.configuration
      end

      def connection
        @connection ||= lambda do
          config.connection
        end.call
      end

      def perform(method, path, params, headers = nil, options = nil)
        raise NoMethodError, "#{method} not implemented" unless config.request_types.include?(method)

        send(method, path, params || {}, headers || {}, options || {})
      end

      def request(method, path, params = {}, headers = {}, options = {}) # rubocop:disable Metrics/MethodLength
        sanitize_headers!(method, path, params, headers)
        raise_not_authenticated if headers.keys.include?('Token') && headers['Token'].blank?
        connection.send(method.to_sym, path, params) do |request|
          request.headers.update(headers)
          options.each { |option, value| request.options.send("#{option}=", value) }
        end.env
      rescue Common::Exceptions::BackendServiceException => e
        # convert BackendServiceException into a more meaningful exception title for Sentry
        raise config.service_exception.new(
          e.key, e.response_values, e.original_status, e.original_body
        )
      rescue Timeout::Error, Faraday::TimeoutError
        Raven.extra_context(service_name: config.service_name, url: config.base_path)
        raise Common::Exceptions::GatewayTimeout
      rescue Faraday::ClientError => e
        error_class = case e
                      when Faraday::ParsingError
                        Common::Client::Errors::ParsingError
                      else
                        Common::Client::Errors::ClientError
                      end

        response_hash = e.response&.to_hash
        client_error = error_class.new(e.message, response_hash&.dig(:status), response_hash&.dig(:body))
        raise client_error
      end

      def sanitize_headers!(_method, _path, _params, headers)
        headers.transform_keys!(&:to_s)

        headers.transform_values! do |value|
          if value.nil?
            ''
          else
            value
          end
        end
      end

      def get(path, params, headers, options)
        request(:get, path, params, headers, options)
      end

      def post(path, params, headers, options)
        request(:post, path, params, headers, options)
      end

      def put(path, params, headers, options)
        request(:put, path, params, headers, options)
      end

      def delete(path, params, headers, options)
        request(:delete, path, params, headers, options)
      end

      def raise_not_authenticated
        raise Common::Client::Errors::NotAuthenticated, 'Not Authenticated'
      end
    end
  end
end