require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validations" do
    context "invalid attributes" do

    end
    context "valid attributes" do

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
