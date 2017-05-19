class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  validates :category, presence: true
end
