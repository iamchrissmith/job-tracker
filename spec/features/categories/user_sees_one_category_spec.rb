require 'rails_helper'

RSpec.feature "User sees one category" do
  scenario "a user sees a category with its jobs" do
    category = create(:category_with_jobs)

    visit category_path(category)

    expect(page).to have_content(category.title)
    expect(page).to have_content("Jobs")
    category.jobs.each do |job|
      expect(page).to have_link job.title, company_job_path(job.company, job)
    end
  end
end
