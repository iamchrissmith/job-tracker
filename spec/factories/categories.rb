FactoryGirl.define do
  sequence(:title) { |n| "Web Development #{n}" }

  factory :category do
    title
  end
end
