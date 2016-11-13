class ProductFeature < ActiveRecord::Base
  self.primary_key = "name"

  FEATURES = %i(sms_voting)

  has_many :competition_features, inverse_of: :product_feature, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
