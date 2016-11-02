class Group < ApplicationRecord
  has_many :memberships
  has_many :admins
  has_many :group_events
  has_many :users, :through => :memberships
  has_many :admin_users, :through => :admins, :source => :user
  has_many :events, :through => :group_events
end
