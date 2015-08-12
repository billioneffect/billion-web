FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| Faker::Internet.email("#{first_name}#{n}") }
    password { Faker::Internet.password(8) }

    factory :admin do
      role_id 2
    end
  end
end
