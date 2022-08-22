# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeatureFlag, type: :model do
  let(:new_flag) { build(:feature_flag) }
  subject(:created_feature) { create(:feature_flag) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#feature_exist?' do
    it 'reaturn true if feature is added to table' do
      expect(created_feature.feature_exist?).to be_truthy
    end
  end

  describe '#activate' do
    context 'when feature is not added in table' do
      it {
        expect(new_flag.activate.enabled).to be_truthy
      }
    end
    context 'when feature is added in table' do
      it {
        expect(created_feature.activate.enabled).to be_truthy
      }
    end
  end

  describe '#deactivate' do
    context 'when feature is not added in table' do
      it {
        expect(new_flag.deactivate.enabled).to be_falsey
      }
    end
    context 'when feature is added in table' do
      it {
        expect(created_feature.deactivate.enabled).to be_falsey
      }
    end
  end

  describe '#active?' do
    context 'when feature is not added in table' do
      it 'return false' do
        expect(new_flag.active?).to be_falsey
      end
    end

    context 'when feature is added in table' do
      let(:activated_feature) { created_feature.activate }
      it 'return true if feature has active status' do
        expect(activated_feature.active?).to be_truthy
      end
      let(:deactivated_feature) { created_feature.deactivate }
      it 'return false if feature is inactive status' do
        expect(deactivated_feature.active?).to be_falsey
      end
    end
  end
end