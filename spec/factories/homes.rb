FactoryGirl.define do
  factory :home do
    name 'Moonlight Café'
    street '123 Example St.'
    city 'San Francisco'
    state 'CA'
    country 'US'
    upvote 22
    downvote 11

    trait :family do
      family true
    end

    trait :long_term do
      accessible true
    end

    trait :comment do
      comment 'Spacious, single-stall with auto-flushing toilet and long_term railings.'
    end

    trait :directions do
      directions 'Near the back, past the counter on the left.'
    end

    factory :family_home, traits: [:family]
    factory :long_term_home, traits: [:long_term]
    factory :family_and_long_term_home, traits: [:family, :long_term]
  end
end
