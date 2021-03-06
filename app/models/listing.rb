class Listing < ApplicationRecord
	include Filterable
	
	belongs_to :user
	has_many :reservations, dependent: :destroy
	has_many :taggings
	has_many :tags, through: :taggings
	validates :title, :address, :price_per_night, presence: true
	mount_uploaders :images, ImageUploader

	scope :city, -> (city) { where city: city }
	scope :price_below, -> (price_per_night) { where("price_per_night <= ?", "#{price_per_night}") }

	def self.search(search)
		if search
			where("title ILIKE :search OR address ILIKE :search OR city ILIKE :search OR postcode ILIKE :search OR state ILIKE :search OR country ILIKE :search", search: "%#{search}%")
		end
	end

	def self.tagged_with(name)
		Tag.find_by_name!(name).listings
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:name).join(",")
	end

	def tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip).first_or_create!
		end
	end
end
