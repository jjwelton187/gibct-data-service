# frozen_string_literal: true

module V0
  class ApiController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :resolve_version

    def cors_preflight
      head(:ok)
    end

    private

    # Newest production data version assumed when version param is undefined
    def resolve_version
      v = params[:version]
      @version = (v.present? && Version.find_by(uuid: v)) || Version.current_production

      raise Common::Exceptions::InvalidFieldValue, "Version #{v} not found" unless @version.try(:number)
    end

    def self_link
      URI.join(Figaro.env.link_host, request.original_fullpath).to_s
    end

    rescue_from 'Exception' do |exception|
      log_error(exception)

      va_exception =
        case exception
        when ActionController::ParameterMissing
          Common::Exceptions::ParameterMissing.new(exception.param)
        when Common::Exceptions::BaseError
          exception
        else
          Common::Exceptions::InternalServerError.new(exception)
        end

      headers['WWW-Authenticate'] = 'Token realm="Application"' if va_exception.is_a?(Common::Exceptions::Unauthorized)
      render json: { errors: va_exception.errors }, status: va_exception.status_code
    end

    def log_error(exception)
      Raven.capture_exception(exception) if ENV['SENTRY_DSN'].present?
      Rails.logger.error "#{exception.message}."
      Rails.logger.error exception.backtrace.join("\n") unless exception.backtrace.nil?
    end
  end
end
