FactoryGirl.define do
  factory :product_feature do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
  end
end
