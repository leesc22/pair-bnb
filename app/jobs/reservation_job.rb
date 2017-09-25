class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer, host, reservation_id)
    ReservationMailer.booking_email(customer, host, reservation_id).deliver_later
    #(wait: 1.hour)
    #(wait_until: 10.hours.from_now)
  end
end
