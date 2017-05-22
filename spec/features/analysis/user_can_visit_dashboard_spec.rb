require 'rails_helper'

RSpec.feature "User can view a dashboard" do
  scenario "a user can visit /dashboard" do
    visit ('/dashboard')
    expect(page).to have_content "Jobs Dashboard"
  end
end
