module PaymentsHelper
	def paid?
		@reservation.payments.sum(:amount) >= @reservation.total_amount
	end
end
