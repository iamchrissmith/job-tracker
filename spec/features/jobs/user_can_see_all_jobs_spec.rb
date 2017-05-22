require 'rails_helper'

RSpec.feature "User can view jobs index" do
  before {
    create(:job, level_of_interest: 1, city: "NYC")
    create(:job, level_of_interest: 1, city: "NYC")
    create(:job, level_of_interest: 1)
    create(:job, level_of_interest: 2)
    create(:job, level_of_interest: 2)
    create(:job, level_of_interest: 3)
  }

  scenario "a user can visit /jobs" do
    visit ('/jobs')
    expect(page).to have_selector('.job', count: 6)
  end

  scenario "a user can view jobs in just one location" do
    visit ('/jobs?location=Denver')
    expect(page).to have_selector('.job', count: 4)

    visit ('/jobs?location=NYC')
    expect(page).to have_selector('.job', count: 2)
  end

  context "when sort is passed" do
    scenario "sort by location" do
      visit ('/jobs?sort=location')
      expect(page).to have_selector('.job:first-child', text: "City: Denver")
      expect(page).to have_selector('.job:last-child', text: "City: NYC")
    end
    scenario "sort by interest" do
      visit ('/jobs?sort=interest')
      expect(page).to have_selector('.job:first-child', text: "Level of Interest: 3")
      expect(page).to have_selector('.job:last-child', text: "Level of Interest: 1")
    end
  end
end
