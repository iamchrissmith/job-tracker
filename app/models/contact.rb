class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :email, presence: true

  belongs_to :company

  def full_name
    "#{first_name} #{last_name}"
  end
end
