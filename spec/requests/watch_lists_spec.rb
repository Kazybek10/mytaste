require "rails_helper"

RSpec.describe "WatchLists", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST /watch_lists" do
    it "redirects guest to login" do
      post watch_lists_path, params: { watch_list: { name: "My List" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a watch list for logged in user" do
      sign_in user
      expect {
        post watch_lists_path, params: { watch_list: { name: "My List" } }
      }.to change(WatchList, :count).by(1)
    end

    it "redirects to profile after creation" do
      sign_in user
      post watch_lists_path, params: { watch_list: { name: "My List" } }
      expect(response).to redirect_to(profile_path)
    end

    it "does not create more than 10 lists" do
      sign_in user
      create_list(:watch_list, 10, user: user)
      expect {
        post watch_lists_path, params: { watch_list: { name: "11th List" } }
      }.not_to change(WatchList, :count)
    end
  end

  describe "PATCH /watch_lists/:id" do
    let(:watch_list) { create(:watch_list, user: user) }

    it "redirects guest to login" do
      patch watch_list_path(watch_list), params: { watch_list: { name: "New Name" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "updates the watch list name" do
      sign_in user
      patch watch_list_path(watch_list), params: { watch_list: { name: "New Name" } }
      expect(watch_list.reload.name).to eq("New Name")
    end

    it "cannot update another user's list" do
      sign_in other_user
      patch watch_list_path(watch_list), params: { watch_list: { name: "Hacked" } }
      expect(response).to have_http_status(404)
    end
  end

  describe "DELETE /watch_lists/:id" do
    let!(:watch_list) { create(:watch_list, user: user) }

    it "redirects guest to login" do
      delete watch_list_path(watch_list)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "deletes the watch list" do
      sign_in user
      expect {
        delete watch_list_path(watch_list)
      }.to change(WatchList, :count).by(-1)
    end

    it "cannot delete another user's list" do
      sign_in other_user
      delete watch_list_path(watch_list)
      expect(response).to have_http_status(404)
    end
  end
end
