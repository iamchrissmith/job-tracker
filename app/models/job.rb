class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  validates :category, presence: true
  has_many :comments, dependent: :destroy

  def display_comments
    comments.order(updated_at: :desc)
  end

  def self.by_level_of_interest
    Job.group(:level_of_interest).order('count_id desc').count(:id)
  end
end
