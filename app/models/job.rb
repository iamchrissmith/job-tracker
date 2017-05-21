class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  validates :category, presence: true
  has_many :comments

  def display_comments
    comments.order(updated_at: :desc)
  end
end
