FactoryGirl.define do
  factory :competition, aliases: [:inactive_competition] do
    competition_config
    code_name { Faker::Lorem.word }
    start_date { Faker::Date.backward(5) }
    end_date { Faker::Date.forward(5) }
    active false

    trait :with_projects do
      after(:build, :stub) do |competition|
        create_list(:project, 1, competition: competition)
      end
    end

    factory :current_competition do
      active true
    end
  end
end
