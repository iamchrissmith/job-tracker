require 'rails_helper'

describe "User edits an existing job" do
  context "with valid params" do
    scenario "a user can edit a job title" do
      job = create(:job)
      company = job.company
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[title]", with: "New Job Title"
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_content "New Job Title"
      expect(page).not_to have_content "Developer"
    end

    scenario "a user can edit a job level_of_interest" do
      job = create(:job)
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[level_of_interest]", with: 30
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_content 30
      expect(page).not_to have_content 70
    end

    scenario "a user can edit a job city" do
      job = create(:job)
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[city]", with: "Casper"
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_content "Casper"
      expect(page).not_to have_content "Denver"
    end
  end
  context "with invalid params" do
    scenario "a user can edit a job title" do
      job = create(:job)
      company = job.company
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[title]", with: ""
      click_button "Update Job"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "a user can edit a job level_of_interest" do
      job = create(:job)
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[level_of_interest]", with: ''
      click_button "Update Job"

      expect(page).to have_content "Level of interest can't be blank"
    end

    scenario "a user can edit a job city" do
      job = create(:job)
      company = job.company
      visit edit_company_job_path(company, job)

      fill_in "job[city]", with: ""
      click_button "Update Job"

      expect(page).to have_content "City can't be blank"
    end
  end
end
