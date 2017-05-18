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
  context "with invalid params" do
    scenario "a user cannot create a category without a title" do
      visit new_category_path

      fill_in "category[title]", with: nil

      click_button "Create Category"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "a user cannot create a category with an existing title" do
      category = create(:category)
      visit new_category_path

      fill_in "category[title]", with: category.title

      click_button "Create Category"

      expect(page).to have_content "Title has already been taken"
    end
  end
end
