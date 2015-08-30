FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    blurb { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph(10) }
    competition

    trait :with_comments do
      after(:build, :stub) do |project|
        create_list(:comment, 2, project: project)
      end
    end

    trait :with_collaborators do
      after(:build, :stub) do |project|
        create_list(:membership, 3, project: project)
      end
    end

    trait :with_competitor do
      association :competitor, factory: :project
    end
  end
end
