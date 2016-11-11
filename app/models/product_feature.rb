class ProductFeature < ActiveRecord::Base
  self.primary_key = "name"

  has_many :competition_features, inverse_of: :product_feature, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
