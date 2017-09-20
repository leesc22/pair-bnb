class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

  validate :checkin_date_cannot_be_in_the_past,
    :checkout_date_cannot_be_less_than_checkin_date
  before_save :calculate_total_amount

  def checkin_date_cannot_be_in_the_past
    errors.add(:checkin_date, "can't be in the past") if
      !checkin_date.blank? and checkin_date < Date.today
  end

  def checkout_date_cannot_be_less_than_checkin_date
    errors.add(:checkout_date, "can't be less than or equal to Checkin date") if
      !checkout_date.blank? and checkout_date <= checkin_date
  end

  def calculate_total_amount
    self.total_amount = self.listing.price_per_night * (self.checkout_date.to_date() - self.checkin_date.to_date()).to_i
  end
end
