# frozen_string_literal: true

class CalculatorConstant < ActiveRecord::Base
  include CsvHelper

  CSV_CONVERTER_INFO = {
    'name' => { column: :name, converter: UpcaseConverter },
    'value' => { column: :float_value, converter: NumberConverter }
  }.freeze

  default_scope { order('name') }

  validates :name, uniqueness: true, presence: true
  validates :float_value, presence: true

  # Support for GIBCT using value
  def value
    float_value
  end

  scope :version, lambda { |version|
    # TODO: where(version: version)
  }
end
