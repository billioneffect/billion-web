require 'rails_helper'

describe CompetitionConfig, :type => :model do
  describe 'assocations' do
    it { is_expected.to belong_to(:competition).inverse_of(:competition_config) }
  end

  describe 'validations' do
    it do
      is_expected.to validate_numericality_of(:sms_votes_allowed)
        .is_greater_than_or_equal_to(1)
        .only_integer
    end

    it do
      is_expected.to validate_numericality_of(:dollar_to_point)
        .is_greater_than_or_equal_to(1)
        .only_integer
    end
  end
end
