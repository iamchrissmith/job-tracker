require 'rails_helper'

RSpec.feature "User edits an existing job" do
  context "with valid params" do
    scenario "a user can edit a job title" do
      category = create(:category)
      job = create(:job, category: category)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[title]", with: "New Job Title"
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_content "New Job Title"
      expect(page).to have_link "#{category.title}", category_path(category)
      expect(page).not_to have_content "Developer"
    end

    scenario "a user can edit a job level_of_interest" do
      category = create(:category)
      job = create(:job, category: category)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[level_of_interest]", with: 30
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_link "#{category.title}", category_path(category)
      expect(page).to have_content 30
      expect(page).not_to have_content 70
    end

    scenario "a user can edit a job city" do
      category = create(:category)
      job = create(:job, category: category)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[city]", with: "Casper"
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_content "Casper"
      expect(page).to have_link "#{category.title}", category_path(category)
      expect(page).not_to have_content "Denver"
    end

    scenario "a user can edit a job category" do
      category = create(:category)
      job = create(:job, category: category)
      company = job.company
      new_category = create(:category)

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      select new_category.title, :from => "job[category_id]"
      click_button "Update Job"
      job.reload

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content "#{job.title} updated!"
      expect(page).to have_link "#{new_category.title}", category_path(new_category)
      expect(page).not_to have_link "#{category.title}", category_path(category)
    end
  end

  context "with invalid params" do
    scenario "a user cannot edit a job without a title" do
      job = create(:job)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[title]", with: ""
      click_button "Update Job"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "a user cannot edit a job without level_of_interest" do
      job = create(:job)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[level_of_interest]", with: ''
      click_button "Update Job"

      expect(page).to have_content "Level of interest can't be blank"
    end

    scenario "a user cannot edit a job without city" do
      job = create(:job)
      company = job.company

      visit company_path(company)

      within(".job-#{job.id}") do
        click_link "Edit"
      end

      fill_in "job[city]", with: ""
      click_button "Update Job"

      expect(page).to have_content "City can't be blank"
    end
  end
end
