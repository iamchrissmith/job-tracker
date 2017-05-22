require 'rails_helper'

RSpec.feature "User creates a new contact without valid attributes" do
  context "when entering invalid params on company page" do
    scenario "a user is directed to the contact new page with errors" do
      company = create(:company)

      visit company_path(company)

      fill_in "contact[first_name]", with: ""
      fill_in "contact[last_name]", with: "Doe"
      fill_in "contact[position]", with: "CEO"
      fill_in "contact[email]", with: "jane@company.com"

      click_button "Create Contact"

      expect(page).to have_content "First name can't be blank"
    end
  end

  context "when valid params are entered on contact create page" do
    scenario "a contact is created and the user is directed to the company page" do
      company = create(:company)

      visit new_company_contact_path(company)

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
end
