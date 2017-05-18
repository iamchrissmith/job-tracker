FactoryGirl.define do
  sequence(:title) { |n| "Web Development" }

  factory :category do
    title
  end
end
