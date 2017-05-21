FactoryGirl.define do
  factory :contact do
    company
    first_name "Jane"
    last_name "Doe"
    position "CEO"
    email "jane@janescompany.com"
  end
end
