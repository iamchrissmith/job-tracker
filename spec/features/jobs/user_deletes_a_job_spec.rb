require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    job = create(:job)
    company = job.company

    visit company_path(company)

    within(".job-#{job.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Job ID #{job.id} was successfully deleted!")

  end
end
