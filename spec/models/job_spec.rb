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

  describe "self.top_companies" do
    let(:company_1) {create(:company)}
    let(:company_2) {create(:company)}
    let(:company_3) {create(:company)}
    before {
      create(:job, level_of_interest: 1, company: company_1)
      create(:job, level_of_interest: 1, company: company_1)
      create(:job, level_of_interest: 1, company: company_1)
      create(:job, level_of_interest: 2, company: company_2)
      create(:job, level_of_interest: 2, company: company_2)
      create(:job, level_of_interest: 3, company: company_3)
    }

    it "returns a hash of the level of interests" do
      expect(Job.top_companies(3)).to match({
        "#{company_3.name}" => 3,
        "#{company_2.name}" => 2,
        "#{company_1.name}" => 1
      })
    end
  end

  describe "self.locations" do
    before {
      create(:job, city: "NYC")
      create(:job, city: "NYC")
      create(:job)
      create(:job)
      create(:job)
      create(:job)
    }

    it "returns a hash of the locations with job count" do
      expect(Job.locations).to match({
        "Denver" => 4,
        "NYC" => 2
      })
    end
  end
end
