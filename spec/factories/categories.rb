FactoryGirl.define do
  sequence(:title) { |n| "Web Development #{n}" }

  factory :category do
    title

    factory :category_with_jobs do
      transient do
        jobs_count 3
      end

      after(:create) do |category, evaluator|
        create_list(:job, evaluator.jobs_count, category: category)
      end
    end
  end
end
