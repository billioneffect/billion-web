FactoryGirl.define do
  factory :round, aliases: [:active_round] do
    association :competition, factory: :competition
    started_at { 1.day.ago }
    ended_at { 1.day.from_now }
    round_number { Faker::Number.between(1, 10) }

    factory :inactive_round do
      started_at { 2.days.ago }
      ended_at { 1.day.ago }
    end
  end
end
