require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a first_name" do
        contact = build(:contact, first_name: '')
        expect(contact).to be_invalid
      end

      it "is invalid without a last_name" do
        contact = build(:contact, last_name: '')
        expect(contact).to be_invalid
      end

      it "is invalid without a position" do
        contact = build(:contact, position: '')
        expect(contact).to be_invalid
      end

      it "is invalid without a email" do
        contact = build(:contact, email: '')
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with all the attributes included" do
        contact = create(:contact)
        expect(contact).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      contact = create(:contact)
      expect(contact).to respond_to(:company)
    end
  end

  describe ".full_name" do
    it "returns the first and last name" do
      contact = create(:contact)
      expect(contact.full_name).to eq "#{contact.first_name} #{contact.last_name}"
    end
  end
end
