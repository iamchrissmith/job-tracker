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

  xscenario "a user can view jobs in just one location" do
    visit ('/jobs?location=Denver')
    expect(page).to have_selector('.job', count: 4)

    visit ('/jobs?location=NYC')
    expect(page).to have_selector('.job', count: 2)
  end

  context "when sort is passed" do
    xscenario "sort by interest" do

    end
    xscenario "sort by location" do

    end
  end
end
