# frozen_string_literal: true

class ZipcodeRate < ActiveRecord::Base
  include CsvHelper

  CSV_CONVERTER_INFO = {
    'zip_code' => { column: :zip_code, converter: ZipConverter },
    'mha_code' => { column: :mha_code, converter: BaseConverter },
    'mha_name' => { column: :mha_name, converter: BaseConverter },
    'mha_rate' => { column: :mha_rate, converter: NumberConverter },
    'mha_rate_grandfathered' => { column: :mha_rate_grandfathered, converter: NumberConverter }
  }.freeze

  validates :version, presence: true

  scope :version, ->(n) { where(version: n) }
end
