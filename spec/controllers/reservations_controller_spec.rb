require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do

	let(:user) {User.create(name: "David Lim", email: "david@example.com", password: "123456")}
  let(:listing) {Listing.create(user_id: user.id, title: "sea view room", address: "seaside", city: "kuala tng", postcode: "21000", state: "terengganu", country: "Malaysia", price_per_night: 175, room_type: "Private room", smoking_allowed: false, pets_allowed:false, wifi: false, pool:false)}
  let(:valid_params) {{ reservation: { checkin_date: Date.today + 4.day, checkout_date: Date.today + 6.day, guest_no: 1, user_id: user.id, listing_id: listing.id}}}
  let(:invalid_params) {{ reservation: { checkin_date: Date.today + 2.day, checkout_date: Date.today + 4.day, guest_no: 1, user_id: user.id, listing_id: listing.id}}}

  describe "GET #show" do
    before do
      sign_in
      reservation = FactoryGirl.create(:reservation)
      get :show, params: { id: reservation.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    before do
      sign_in
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns instance reservation" do
      expect(assigns[:reservation]).to be_a Reservation
    end
  end

  describe "POST #create" do
    before do
      sign_in
      # reservation = FactoryGirl.create(:reservation)
      reservation = Reservation.create(user_id: user.id, listing_id: listing.id, checkin_date: Date.today + 1.day, checkout_date: Date.today + 3.day, guest_no: 1)
    end
    # happy_path
    context "valid_params" do
      it "creates new reservation if params are correct" do
      	expect{post :create, params: valid_params}.to change{Reservation.count}.by(1)
        byebug
      end

      it 'redirects reservation path and displays flash notice after reservation is created successfully' do
        post :create, params: valid_params
        expect(response).to redirect_to(Reservation.last)
        # expect(flash[:notice]).to eq "Listing is created successfully."
      end
    end

    # unhappy_path
    context "invalid_params" do
      before do
        sign_in
        post :create, params: invalid_params
      end

      # it "displays flash alert message" do
      #   expect(flash[:alert]).to include "Error creating listing."
      # end

      it "renders new template again" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in
    end

    it "destroys the requested status" do
      reservation = Reservation.create(user_id: user.id, listing_id: listing.id, checkin_date: Date.today + 1.day, checkout_date: Date.today + 3.day, guest_no: 1)
      expect {
        delete :destroy, params: { id: reservation.id }
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the statuses_path" do
      reservation = Reservation.create(user_id: user.id, listing_id: listing.id, checkin_date: Date.today + 1.day, checkout_date: Date.today + 3.day, guest_no: 1)
      delete :destroy, params: { id: reservation.id }
      expect(response).to redirect_to(user_reservations_path(reservation.user_id))
      # expect(flash[:notice]).to eq "Reservation is deleted."
    end
  end

end
