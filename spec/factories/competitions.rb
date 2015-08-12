FactoryGirl.define do
  factory :competition do
    code_name { Faker::Lorem.word }
    start_date { Faker::Date.backward(5) }
    end_date { Faker::Date.forward(5) }

    trait :with_projects do
      after(:build, :stub) do |competition|
        create_list(:project, 1, competition: competition)
      end
    end
  end
end
