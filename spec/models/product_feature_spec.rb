require 'rails_helper'

describe ProductFeature, :type => :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:competition_features).inverse_of(:product_feature) }
  end
end
