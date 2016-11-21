class Profile < ApplicationRecord
	belongs_to :user

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX }
  validates :musical_role, presence: true, length: { maximum: 50 }
  validates :interests, length: { maximum: 100 }
  validates :other, length: { maximum: 100 }
end
