require 'rails_helper'

describe "User sees all companies" do
  scenario "a user sees all the companies" do
    company = create(:company)
    company_two = create(:company, name: "Disney")

    visit companies_path

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Disney")
  end

end
