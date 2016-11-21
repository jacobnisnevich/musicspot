class Announcement < ApplicationRecord
	belongs_to :group

	validates :title, presence: true, length: { maximum: 50 }
	validates :description, presence: true
end
