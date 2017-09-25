class ReservationMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def booking_email(customer, host, reservation_id)
		@customer = customer
		@url = reservation_url(reservation_id)
		mail(to: host.email, subject: "PairBnB Booking #{reservation_id}")
	end
end
