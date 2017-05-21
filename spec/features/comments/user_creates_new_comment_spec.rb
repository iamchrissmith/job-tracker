require 'rails_helper'

RSpec.feature "User creates a new comment" do
  let(:comment_author) {"Jane Doe"}
  let(:comment_comment) {"Test Comment."}

  context "with valid params" do
    scenario "a user can create a new commment" do
      job = create(:job)
      
      visit job

      fill_in "comment[author]", with: comment_author
      fill_in "comment[comment]", with: comment_comment

      click_button "Create Comment"

      expect(current_path).to eq job
      expect(page).to have_content comment_author
      expect(page).to have_content comment_comment
      expect(page).to have_content Date.now
    end
  end
  context "with invalid params" do
    scenario "a user cannot create a comment without an author" do
      job = create(:job)

      visit job

      fill_in "comment[comment]", with: comment_comment

      click_button "Create Comment"

      expect(page).to have_content "Author can't be blank"
    end

    scenario "a user cannot create a comment without an author" do
      job = create(:job)

      visit job

      fill_in "comment[author]", with: comment_author

      click_button "Create Comment"

      expect(page).to have_content "Comment can't be blank"
    end
  end
end
