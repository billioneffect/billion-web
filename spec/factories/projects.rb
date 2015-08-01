FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    blurb { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph }

    trait :with_comments do
      after :create do |project|
        create_list(:comment, 2, project: project)
      end
    end

    trait :with_collaborators do
      after :create do |project|
        create_list(:collaborator, 1, project: project)
      end
    end
  end
end
