FactoryGirl.define do
  sequence(:name) { |n| "ESPN #{n}" }

  factory :company do
    name
  end
end
