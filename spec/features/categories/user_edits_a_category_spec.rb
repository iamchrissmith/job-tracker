require 'rails_helper'

RSpec.feature "User edits a category" do
  context "with valid params" do
    scenario "a user can edit a category" do
      category = create(:category)

      visit categories_path

      within(".category-#{category.id}") do
        click_link "Edit"
      end

      fill_in "category[title]", with: "New Category Title"
      click_button "Update Category"
      category.reload

      expect(current_path).to eq(category_path(category))
      expect(page).to have_content "Category updated!"
      expect(page).to have_content "New Category Title"
      expect(page).not_to have_content "Web Development"
    end
  end

  context "with invalid params" do
    scenario "a user cannot create a category without a title" do
      category = create(:category)

      visit edit_category_path(category)

      fill_in "category[title]", with: nil

      click_button "Update Category"

      expect(page).to have_content "Title can't be blank"
    end

    scenario "a user cannot create a category with an existing title" do
      category = create(:category)
      category_2 = create(:category, title: "Second Category")

      visit edit_category_path(category)

      fill_in "category[title]", with: category_2.title

      click_button "Update Category"

      expect(page).to have_content "Title has already been taken"
    end
  end
end
