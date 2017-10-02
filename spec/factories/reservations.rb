FactoryGirl.define do
  factory :reservation do
  	user
  	listing
    checkin_date { Date.today + 1.day }
    checkout_date { Date.today + 3.day }
    guest_no 1
  end

  factory :reservation_valid, class: Reservation do
  	user
  	listing
    checkin_date { Date.today + 4.day }
    checkout_date { Date.today + 6.day }
    guest_no 1
  end

  factory :reservation_invalid, class: Reservation do
  	user
  	listing
    checkin_date { Date.today + 2.day }
    checkout_date { Date.today + 4.day }
    guest_no 1
  end

  factory :reservation1, class: Reservation do
    user1
    listing1
    checkin_date { Date.today + 2.day }
    checkout_date { Date.today + 4.day }
    guest_no 1
  end
end
