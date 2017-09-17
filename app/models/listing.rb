class Listing < ApplicationRecord
	belongs_to :user
	validates :title, :address, :price_per_night, presence: true

	def self.search(search)
		if search
			where("title LIKE :search OR address LIKE :search", search: "%#{search}%")
		else
			all
		end
	end
end
