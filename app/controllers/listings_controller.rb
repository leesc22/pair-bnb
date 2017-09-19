
class ListingsController < ApplicationController
	def index
		if params[:page].nil? || params[:page].empty?
			@current_page = 1
		else
			@current_page = params[:page].to_i
		end
		offset = (@current_page -  1) * 10
		if params[:tag]
			seach_results = Listing.tagged_with(params[:tag])
		else
			seach_results = Listing.search(params[:search]).order(created_at: :desc)
		end
		@pages = seach_results.count.div 10 + 1
		@listings = seach_results.limit(10).offset(offset)
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@listing = Listing.new
	end

	def create
		puts listing_params
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to @listing
		else
			render 'new'
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if current_user.listings.find(params[:id]).update(listing_params)
			redirect_to @listing
		else
			render 'edit'
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	def user_listings
		@user = User.find(params[:id])
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :tag_list, :address, :city, :postcode, :state, :country, :price_per_night, :room_type, :smoking_allowed, :pets_allowed, :wifi, :pool)
	end
end
