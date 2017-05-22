require 'rails_helper'

RSpec.feature "User creates a new job" do
  context "with valid params" do
    scenario "a user can create a new job" do
      company = create(:company)
      category = create(:category)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"

      select category.title, :from => "job[category_id]"
      expect(page).to have_link "Add new category", new_category_path

      click_button "Create"

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
      expect(page).to have_content("ESPN")
      expect(page).to have_content("Developer")
      expect(page).to have_content("80")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Category: #{category.title}")
    end
  end
  context "with invalid params" do
    scenario "a user cannot create a job without a title" do
      company = create(:company)
      category = create(:category)
      visit new_company_job_path(company)

      fill_in "job[title]", with: ""
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"

      select category.title, :from => "job[category_id]"
      expect(page).to have_link "Add new category", new_category_path

      click_button "Create"


      expect(page).to have_content "Title can't be blank"
    end

    scenario "a user cannot create a job without level_of_interest" do
      company = create(:company)
      category = create(:category)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: ''
      fill_in "job[city]", with: "Denver"

      select category.title, :from => "job[category_id]"
      expect(page).to have_link "Add new category", new_category_path

      click_button "Create"


      expect(page).to have_content "Level of interest can't be blank"
    end

    scenario "a user cannot create a job without city" do
      company = create(:company)
      category = create(:category)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: ""

      select category.title, :from => "job[category_id]"
      expect(page).to have_link "Add new category", new_category_path

      click_button "Create"

      expect(page).to have_content "City can't be blank"
    end

    scenario "a user cannot create a job without a category" do
      company = create(:company)
      category = create(:category)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"

      expect(page).to have_link "Add new category", new_category_path

      click_button "Create"

      expect(page).to have_content "Category can't be blank"
    end
  end
end
