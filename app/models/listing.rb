class Listing < ApplicationRecord
	belongs_to :user
	validates :title, :address, :price_per_night, presence: true

	def self.search(search)
		if search
			where("title ILIKE :search OR address ILIKE :search OR city ILIKE :search OR postcode ILIKE :search OR state ILIKE :search OR country ILIKE :search", search: "%#{search}%")
		else
			all
		end
	end
end
