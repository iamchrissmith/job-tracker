require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:comment) }
  end
end
