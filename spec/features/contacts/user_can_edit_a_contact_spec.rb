require 'rails_helper'

RSpec.feature "User edits an existing contact" do
  context "with valid params" do
    scenario "a user can edit a contact name" do
      contact = create(:contact)
      company = contact.company

      visit company_path(company)

      within(".contact-#{contact.id}") do
        click_link "Edit"
      end

      fill_in "contact[first_name]", with: "New First"
      fill_in "contact[last_name]", with: "New Last"
      click_button "Update Contact"
      contact.reload

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content "#{contact.full_name} updated!"
      expect(page).to have_content "New First New Last"
    end

    scenario "a user can edit a contact position" do
      contact = create(:contact)
      company = contact.company

      visit company_path(company)

      within(".contact-#{contact.id}") do
        click_link "Edit"
      end

      fill_in "contact[position]", with: "New Position"
      click_button "Update Contact"
      contact.reload

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content "#{contact.full_name} updated!"
      expect(page).to have_content "New Position"
    end

    scenario "a user can edit a contact email" do
      contact = create(:contact)
      company = contact.company

      visit company_path(company)

      within(".contact-#{contact.id}") do
        click_link "Edit"
      end

      fill_in "contact[email]", with: "New Email"
      click_button "Update Contact"
      contact.reload

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content "#{contact.full_name} updated!"
      expect(page).to have_content "New Email"
    end
  end

  context "with invalid params" do
    scenario "a user cannot edit a contact without entering all params" do
      contact = create(:contact)
      company = contact.company

      visit company_path(company)

      within(".contact-#{contact.id}") do
        click_link "Edit"
      end

      fill_in "contact[first_name]", with: ""
      fill_in "contact[last_name]", with: ""
      fill_in "contact[position]", with: ""
      fill_in "contact[email]", with: ""
      click_button "Update Contact"
      contact.reload

      expect(page).to have_content "First name can't be blank"
      expect(page).to have_content "Last name can't be blank"
      expect(page).to have_content "Position can't be blank"
      expect(page).to have_content "Email can't be blank"
    end
  end
end
