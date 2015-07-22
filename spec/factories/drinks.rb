FactoryGirl.define do
  factory :drink do
    sequence(:name) { |n| "Drink#{n}" }
    price 1000
    menu
  end

end
