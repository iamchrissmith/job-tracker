require 'rails_helper'

RSpec.feature "User creates a new comment" do
  let(:comment_author) {"Jane Doe"}
  let(:first_comment) {"Test Comment."}
  let(:second_comment) {"Test Second Comment."}

  context "with valid params" do
    scenario "a user can create a new commment" do
      job = create(:job)

      visit company_job_path(job.company, job)

      fill_in "comment[author]", with: comment_author
      fill_in "comment[comment]", with: first_comment
      Timecop.travel(Time.local(2017, 5, 20, 10, 0 ,0)) do
        click_button "Create Comment"

        expect(current_path).to eq company_job_path(job.company, job)
        expect(page).to have_content "Your comment has been added."
        expect(page).to have_content comment_author
        expect(page).to have_content first_comment
        expect(page).to have_content DateTime.now.to_date.strftime("%b %d, %Y")
      end
    end
    scenario "a user's second comment shows at the top of the list" do
      job = create(:job)

      visit company_job_path(job.company, job)

      fill_in "comment[author]", with: comment_author
      fill_in "comment[comment]", with: first_comment
      Timecop.travel(Time.local(2017, 5, 20, 10, 0 ,0)) do
        click_button "Create Comment"

        expect(current_path).to eq company_job_path(job.company, job)

        expect(page).to have_css('.comments .comment:first-of-type', :text => first_comment)
      end

      fill_in "comment[author]", with: comment_author
      fill_in "comment[comment]", with: second_comment

      Timecop.travel(Time.local(2017, 5, 20, 11, 0 ,0)) do
        click_button "Create Comment"
        save_and_open_page

        expect(current_path).to eq company_job_path(job.company, job)

        expect(page).to have_css('.comment:first-child', :text => second_comment)
      end
    end

  end
  context "with invalid params" do
    scenario "a user cannot create a comment without an author" do
      job = create(:job)

      visit company_job_path(job.company, job)

      fill_in "comment[comment]", with: first_comment

      click_button "Create Comment"

      expect(page).to have_content "Author can't be blank"
    end

    scenario "a user cannot create a comment without a comment" do
      job = create(:job)

      visit company_job_path(job.company, job)

      fill_in "comment[author]", with: comment_author

      click_button "Create Comment"

      expect(page).to have_content "Comment can't be blank"
    end
  end
end
