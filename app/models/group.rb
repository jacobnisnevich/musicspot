class Group < ApplicationRecord
  has_many :memberships
  has_many :admins
  has_many :group_events
  has_many :applications
  has_many :users, :through => :memberships
  has_many :admin_users, :through => :admins, :source => :user
  has_many :events, :through => :group_events
  has_many :user_apps, :through => :applications

  validates :name, presence: true, length: { maximum: 50 }
  VALID_ZIP_REGEX = /\A\d{5}(-\d{4})?\z|\A\d{3}\z/
  validates :location, presence: true, length: { maximum: 10 }, format: { with: VALID_ZIP_REGEX }
  validates :group_type, presence: true
end
