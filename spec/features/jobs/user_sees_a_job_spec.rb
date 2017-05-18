require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    job = create(:job)
    company = job.company

    visit company_job_path(company, job)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
end
