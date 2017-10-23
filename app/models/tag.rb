class Tag < ApplicationRecord
	has_many :taggings, dependent: :destroy
	has_many :listings, through: :taggings, dependent: :destroy
end
