require 'rails_helper'

describe CompetitionFeature, :type => :model do
  describe 'validations' do
    subject { build :competition_feature }
    it { is_expected.to validate_presence_of(:competition) }
    it { is_expected.to validate_presence_of(:product_feature) }

    it 'validates only one instance of a feature per competition' do
      feature = create :product_feature, name: 'my-feature'
      competition = create :competition
      comp_feature = build :competition_feature, competition: competition, product_feature: feature
      comp_feature.save

      feature = feature.dup
      expect(feature).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:competition).inverse_of(:competition_features)}
    it { is_expected.to belong_to(:product_feature).inverse_of(:competition_features)}
  end
end
