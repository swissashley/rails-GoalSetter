require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the sign up page" do
      # TODO do we need the empty hash?
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of username and password" do
        post :create, user: {username: "user" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirect to goal index page" do
        post :create, user: {username: "user", password: "password" }
        expect(response).to redirect_to(goals_url)
      end
    end
  end
end
