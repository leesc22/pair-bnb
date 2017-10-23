class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
  has_many :payments, dependent: :destroy

  validates :guest_no, numericality: { greater_than: 0}, presence: true
  validate :checkin_date_cannot_be_in_the_past,
    :checkout_date_cannot_be_less_than_checkin_date,
    :date_cannot_be_overlap
  before_save :calculate_total_amount

  def checkin_date_cannot_be_in_the_past
    errors.add(:checkin_date, "can't be in the past") if
      !checkin_date.blank? and checkin_date < Date.today
  end

  def checkout_date_cannot_be_less_than_checkin_date
    errors.add(:checkout_date, "must be more than  Checkin date") if
      !checkout_date.blank? and checkout_date <= checkin_date
  end

  def date_cannot_be_overlap
    Reservation.where(listing_id: listing_id).each do |reservation|
      if (checkin_date..checkout_date).overlaps?(reservation.checkin_date..reservation.checkout_date)
        return errors.add(:checkin_date, "can't be overlap with other reservations")
      end
    end
  end

  def calculate_total_amount
    self.total_amount = self.listing.price_per_night * (self.checkout_date.to_date() - self.checkin_date.to_date()).to_i
  end

  def send_reservation_email_to_host
    ReservationJob.perform_later(self.user, self.listing.user, self.id)
  end
end
