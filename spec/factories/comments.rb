FactoryGirl.define do
  factory :comment do
    author { Faker::Internet.user_name }
    content { Faker::Lorem.paragraph }
    project
  end
end
