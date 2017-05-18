require 'rails_helper'

RSpec.feature "User creates a new category" do
  context "with valid params" do
    scenario "a user can create a new category" do
      category_title = "Web Development"
      visit new_category_path

      fill_in "category[title]", with: category_title

      click_button "Create Category"

      expect(current_path).to eq category_path(Category.first)
      expect(page).to have_content category_title
    end
  end
end
