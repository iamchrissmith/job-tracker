require 'rails_helper'

RSpec.feature "User can view a dashboard" do
  before {
    create(:job, level_of_interest: 1)
    create(:job, level_of_interest: 1)
    create(:job, level_of_interest: 1)
    create(:job, level_of_interest: 2)
    create(:job, level_of_interest: 2)
    create(:job, level_of_interest: 3)
  }

  scenario "a user can visit /dashboard" do
    visit ('/dashboard')
    expect(page).to have_content "Jobs Dashboard"
  end

  scenario "a user can see a count of jobs by level_of_interest" do
    visit ('/dashboard')
    expect(page).to have_content "Count by level of interest"
    expect(page).to have_css('.count_level_of_interest_1', :text => "3")
    expect(page).to have_css('.count_level_of_interest_2', :text => "2")
    expect(page).to have_css('.count_level_of_interest_3', :text => "1")
  end
end
