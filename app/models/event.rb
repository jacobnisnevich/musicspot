class Event < ApplicationRecord
  has_many :group_events
  has_many :event_users
  has_many :groups, :through => :group_events
  has_many :users, :through => :event_users

  validates :name, presence: true, length: { maximum: 50 }
  VALID_ZIP_REGEX = /\A\d{5}(-\d{4})?\z|\A\d{3}\z/
  validates :location, presence: true, length: { maximum: 10 }, format: { with: VALID_ZIP_REGEX }
  validates :start_datetime, presence: true
  validates :image, format: { with: URI::regexp(%w(http https))}, :allow_blank => true
end
