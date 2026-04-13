require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  describe "GET /profile" do
    it "redirects guest to login" do
      get profile_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns 200 for logged in user" do
      sign_in user
      get profile_path
      expect(response).to have_http_status(200)
    end
  end
end
