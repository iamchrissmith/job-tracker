require 'rails_helper'

RSpec.feature "User deletes a category" do
  scenario "a user can delete a category" do
    category = create(:category)
    visit categories_path

    within(".category-#{category.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("#{category.title} was successfully deleted!")
  end
end
