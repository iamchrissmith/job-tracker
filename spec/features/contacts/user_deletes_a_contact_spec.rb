require 'rails_helper'

RSpec.feature "User deletes a contact" do
  scenario "a user can delete a contact" do
    contact = create(:contact)
    company = contact.company

    visit company_path(company)

    within(".contact-#{contact.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Contact for #{contact.full_name} was successfully deleted!")
    expect(page).not_to have_content(contact.position)
  end
end
