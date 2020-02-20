# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionProgram, type: :model do
  describe 'when validating' do
    subject(:institution_program) { create :institution_program, institution: institution }

    let(:institution) { create :institution, :physical_address }

    it 'has a valid factory' do
      expect(institution_program).to be_valid
    end
  end

  describe 'autocomplete' do
    context 'when search term is program name' do
      before do
        create :version, :production
        create :institution, :start_like_harv, version_id: Version.current_production.id
        create_list(:institution_program, 2, :start_like_harv, institution_id: Institution.last.id)
      end

      it 'returns collection of programs with program name matches' do
        create(:institution_program)
        expect(described_class.autocomplete('harv', Version.last).length).to eq(2)
      end

      it 'limits results' do
        expect(described_class.autocomplete('harv', Version.last, 1).length).to eq(1)
      end
    end
  end

  describe 'class methods' do
    context 'versioning' do
      it 'retrieves institutions by a specific version number' do
        create :version, :production
        create :institution, :physical_address, version_id: Version.last.id
        i = create_list :institution_program, 2, institution: Institution.last

        create :version, :production
        create :institution, :physical_address, version_id: Version.last.id
        j = create_list :institution_program, 2, institution: Institution.last

        expect(described_class.joins(:institution)
                              .joins('INNER JOIN versions v ON v.id = institutions.version_id')
                              .where('v.number = 1')).to match_array(i.to_a)
        expect(described_class.joins(:institution)
                              .joins('INNER JOIN versions v ON v.id = institutions.version_id')
                              .where('v.number = 2')).to match_array(j.to_a)
      end

      it 'returns blank if a non-existent or null version_id is supplied' do
        create :version, :production
        create :institution, :physical_address, version_id: Version.last.id
        create :institution_program, institution: Institution.last

        expect(described_class.joins(:institution)
                              .joins('INNER JOIN versions v ON v.id = institutions.version_id')
                              .where('v.number = -1')).to eq([])
        expect(described_class.joins(:institution)
                              .joins('INNER JOIN versions v ON v.id = institutions.version_id')
                              .where('v.number = ?', nil)).to eq([])
      end
    end

    context 'filter scope' do
      it 'raises an error if no arguments are provided' do
        expect { described_class.filter }.to raise_error(ArgumentError)
      end

      it 'filters on field existing' do
        expect(described_class.filter('description', 'true').to_sql)
          .to include("WHERE \"institution_programs\".\"description\" = 't'")
      end

      it 'filters on field not existing' do
        expect(described_class.filter('description', 'false').to_sql)
          .to include("WHERE \"institution_programs\".\"description\" != 't'")
      end
    end

    context 'search scope' do
      it 'returns nil if no search term is provided' do
        expect(described_class.search(nil)).to be_empty
      end
    end
  end
end
