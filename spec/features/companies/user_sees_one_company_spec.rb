require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = create(:company)
    job = create(:job, company: company)
    contact = create(:contact, company: company)

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content company.name
    expect(page).to have_content job.title
    expect(page).to have_content contact.full_name
  end
  scenario "a user can create a contact from company page" do
    company = create(:company)
    job = create(:job, company: company)
    contact = create(:contact, company: company)

    visit company_path(company)

    fill_in "contact[first_name]", with: "Jane"
    fill_in "contact[last_name]", with: "Doe"
    fill_in "contact[position]", with: "CEO"
    fill_in "contact[email]", with: "jane@company.com"

    click_button "Create Contact"

    expect(current_path).to eq company_path(company)
    expect(page).to have_content "Jane Doe"
    expect(page).to have_content "CEO"
    expect(page).to have_content "jane@company.com"
  end
end
