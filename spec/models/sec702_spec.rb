# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/shared_examples_for_loadable'
require 'models/shared_examples/shared_examples_for_exportable'

RSpec.describe Sec702, type: :model do
  it_behaves_like 'a loadable model', skip_lines: 0
  it_behaves_like 'an exportable model', skip_lines: 0

  describe 'when validating' do
    subject(:sec702) { build :sec702 }

    it 'has a valid factory' do
      expect(sec702).to be_valid
    end

    it 'requires a valid state' do
      expect(build(:sec702, state: nil)).not_to be_valid
      expect(build(:sec702, state: 'BLEECH')).not_to be_valid
    end
  end
end
