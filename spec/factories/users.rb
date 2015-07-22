FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@tipextra.com" }
    password   "dranksNshots"
    first_name "Guy"
    last_name  "Testman"
  end
end
