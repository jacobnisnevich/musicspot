class Announcement < ApplicationRecord
	belongs_to :group

	validates :title, presence: true
	validates :description, presence: true
end
