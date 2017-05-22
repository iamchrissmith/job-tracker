require 'rails_helper'

RSpec.feature "User can view a dashboard" do
  let(:company_1) {create(:company)}
  let(:company_2) {create(:company)}
  let(:company_3) {create(:company)}
  before {
    create(:job, level_of_interest: 1, company: company_1, city: "NYC")
    create(:job, level_of_interest: 1, company: company_1, city: "NYC")
    create(:job, level_of_interest: 1, company: company_1)
    create(:job, level_of_interest: 2, company: company_2)
    create(:job, level_of_interest: 2, company: company_2)
    create(:job, level_of_interest: 3, company: company_3)
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

  scenario "a user can see a top three companies by level_of_interest" do
    visit ('/dashboard')
    expect(page).to have_content "Top three companies by level of interest"
    expect(page).to have_content "#{company_3.name} (3.0)"
    expect(page).to have_content "#{company_2.name} (2.0)"
    expect(page).to have_content "#{company_1.name} (1.0)"
  end

  scenario "a user can a count of jobs by location" do
    visit ('/dashboard')
    expect(page).to have_content "Jobs by location"
    expect(page).to have_link "4 jobs", jobs_path(location: "Denver")
    expect(page).to have_content "Denver 4 jobs"
    expect(page).to have_link "2 jobs", jobs_path(location: "NYC")
    expect(page).to have_content "NYC 2 jobs"
  end
end
