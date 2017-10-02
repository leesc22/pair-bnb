require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	# how to write for clearance/users#new
	# https://thoughtbot.com/upcase/videos/clearance-rails-authentication-made-easy
	# rails generate clearance:specs

  describe "GET #new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns instance reservation" do
      expect(assigns[:user]).to be_a User
    end
  end
end
