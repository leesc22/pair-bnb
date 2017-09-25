class ReservationMailer < ApplicationMailer
	def booking_email(customer, host, reservation_id)
		@customer = customer.name
		@url = 'localhost:3000'
		mail(to: @host, subject: "PairBnB Booking #{reservation_id}")
		# mail(to: @host.email, subject: 'Welcome to PairBnB')
	end
end
