# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Version, type: :model do
  describe 'when validating' do
    subject { build :version, :production }

    let(:no_user) { build :version, user: nil }
    let(:good_existing_version) { build :version, :production, number: 1 }
    let(:bad_existing_version) { build :version, :production, number: 1000 }

    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'requires the requesting user' do
      expect(no_user).not_to be_valid
    end

    context 'and setting a new version' do
      it 'sets the version to the max-version + 1' do
        subject.save
        expect(create(:version, :production).number).to eq(subject.number + 1)
      end
    end

    context 'and rolling back' do
      it 'requires an existing version when rolling back ' do
        subject.save
        expect(good_existing_version).to be_valid
        expect(bad_existing_version).not_to be_valid
      end

      it 'leaves version number as-is' do
        subject.save
        rollback = create :version, :production, number: subject.number
        expect(rollback.number).to eq(subject.number)
      end
    end
  end

  describe 'when determining production and preview versions' do
    before(:each) do
      create :version, :production, created_at: 3.days.ago
      create :version, created_at: 2.days.ago
      create :version, :production, created_at: 1.day.ago
      create :version, created_at: 0.days.ago
    end

    it 'can find the latest production_version' do
      expect(Version.production_version.number).to eq(3)
    end

    it 'can find the latest preview_version' do
      expect(Version.preview_version.number).to eq(4)
    end

    it 'can find the production_version on a given date and time as string' do
      expect(Version.production_version_by_time(2.days.ago.to_s).number).to eq(1)
    end

    it 'can find the production_version on a given date and time as Time' do
      expect(Version.production_version_by_time(2.days.ago).number).to eq(1)
    end

    it 'can find the preview_version on a given date and time as string' do
      expect(Version.preview_version_by_time(1.day.ago.to_s).number).to eq(2)
    end

    it 'can find the preview_version on a given date and time as Time' do
      expect(Version.preview_version_by_time(1.day.ago).number).to eq(2)
    end
  end
end