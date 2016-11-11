class CompetitionFeature < ActiveRecord::Base
  belongs_to :competition, inverse_of: :competition_features
  belongs_to :product_feature, inverse_of: :competition_features

  validates :competition, presence: true
  validates :product_feature, presence: true, uniqueness: true
end
