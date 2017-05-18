require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job title" do
    job = create(:job)
    visit edit_job_path(job)

    fill_in "job[title]", with: "New Job Title"
    click_button "Update Job"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content "New Job Title"
    expect(page).not_to have_content "Developer"
  end

  scenario "a user can edit a job level_of_interest" do
    job = create(:job)
    visit edit_job_path(job)

    fill_in "job[level_of_interest]", with: 30
    click_button "Update Job"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content 30
    expect(page).not_to have_content 70
  end

  scenario "a user can edit a job city" do
    job = create(:job)
    visit edit_job_path(job)

    fill_in "job[city]", with: "Casper"
    click_button "Update Job"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content "Casper"
    expect(page).not_to have_content "Denver"
  end
end
