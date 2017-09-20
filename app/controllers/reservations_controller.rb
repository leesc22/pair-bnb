class ReservationsController < ApplicationController
	before_action :admin_only, only: [:index]

	def index
	end

	def show
	end

	def new
		@reservation = Reservation.new
	end
	
	def create
		@reservation = current_user.reservations.new(reservation_params)
		if @reservation.save
			redirect_to @reservation
		else
			render 'new'
		end
	end

	def destroy
	end

	private

	def reservation_params
		params.require(:reservation).permit(:checkin_date, :checkout_date, :listing_id)
	end
end
