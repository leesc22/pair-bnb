class ReservationsController < ApplicationController
	before_action :customer_only, only: [:new, :create]
	before_action :admin_only, only: [:index]

	def index
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def new
		@reservation = Reservation.new
	end
	
	def create
		@reservation = current_user.reservations.new(reservation_params)
		if @reservation.save
			ReservationMailer.booking_email(@reservation.user, @reservation.listing.user, @reservation.id).deliver_later
			redirect_to @reservation
		else
			render 'new'
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to user_reservations_path
	end

	def user_reservations
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
	end

	private

	def reservation_params
		params.require(:reservation).permit(:listing_id, :checkin_date, :checkout_date, :guest_no)
	end
end
