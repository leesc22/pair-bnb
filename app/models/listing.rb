class Listing < ApplicationRecord
	belongs_to :user
	validates :title, :address, :price_per_night, presence: true
end
