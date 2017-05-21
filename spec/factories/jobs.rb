FactoryGirl.define do
  factory :job do
    company
    category
    title "Developer"
    level_of_interest 70
    city "Denver"

    factory :job_with_comments do
      transient do
        comments_count 3
      end

      after(:create) do |job, evaluator|
        create_list(:comment, evaluator.comments_count, job: job)
      end
    end
  end
end
