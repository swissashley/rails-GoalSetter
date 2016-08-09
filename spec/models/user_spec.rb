# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  describe "user has appropriate validation" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should have_many(:goals) }
  end

  let!(:user) do
    User.create!(username: "user", password: "password")
  end
  describe "User::find_by_credentials" do
    it "finds user with valid credentials" do
      expect(User.find_by_credentials("user", "password")).to eq(user)
    end

    it "returns nil when credentials are invalid" do
      expect(User.find_by_credentials("user", "wersdf")).to be_nil
    end
  end

  describe "has working methods" do
    user = User.new(username: "user", password: "password")

    it "#password= sets password_digest" do
      expect(user.password_digest).not_to be_nil
    end

    it "#reset_session_token! changes user session_token" do
      user.save
      original_session_token = User.first.session_token
      User.first.reset_session_token!

      expect(original_session_token).not_to eq(User.first.session_token)
    end
  end


end
