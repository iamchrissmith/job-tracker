require 'rails_helper'

describe Job do
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
end
