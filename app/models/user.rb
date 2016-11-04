class User < ActiveRecord::Base
  has_many :memberships
  has_many :admins
  has_many :applications
  has_many :groups, :through => :memberships
  has_many :admined_groups, :through => :admins, :source => :groups
  has_many :group_apps, :through => :applications

  has_one :profile

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.save
    end
  end
end
