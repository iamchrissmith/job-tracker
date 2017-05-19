FactoryGirl.define do
  factory :job do
    company
    category
    title "Developer"
    level_of_interest 70
    city "Denver"
  end
end
