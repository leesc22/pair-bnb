
class ListingsController < ApplicationController
	def index
		@listings = Listing.all
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@listing = Listing.new
	end

	def create
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
		params.require(:listing).permit(:title, :address, :price_per_night)
	end
end
