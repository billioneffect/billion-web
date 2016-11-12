class CompetitionConfig < ActiveRecord::Base
  belongs_to :competition, inverse_of: :competition_config

  validates :sms_votes_allowed, numericality: {
    greater_than_or_equal_to: 1,
    only_integer: true
  }

  validates :dollar_to_point, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
end
