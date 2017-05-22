require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = build(:job, title: '')
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = build(:job, level_of_interest: '')
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = build(:job, city: '')
        expect(job).to be_invalid
      end

      it "is invalid without a category" do
        job = build(:job, category: nil)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title and level of interest" do
        job = create(:job)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = create(:job)
      expect(job).to respond_to(:company)
    end

    it "belongs to a category" do
      job = create(:job)
      expect(job).to respond_to(:category)
    end
  end

  describe ".comments" do
    it "returns the comments in decending order" do
      job = create(:job)
      comment_1 = create(:comment, job: job)
      comment_2 = create(:comment, job: job)
      comment_3 = create(:comment, job: job)

      expect(job.display_comments.map(&:author)).to match [comment_3.author,comment_2.author,comment_1.author]
    end
  end

  describe "self.by_level_of_interest" do
    before {
      create(:job, level_of_interest: 1)
      create(:job, level_of_interest: 1)
      create(:job, level_of_interest: 1)
      create(:job, level_of_interest: 2)
      create(:job, level_of_interest: 2)
      create(:job, level_of_interest: 3)
    }
    it "returns a hash of the level of interests" do
      expect(Job.by_level_of_interest).to match({1 => 3, 2 => 2, 3 => 1})
    end
  end
end
