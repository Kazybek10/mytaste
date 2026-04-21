require "rails_helper"

RSpec.describe WatchList, type: :model do
  describe "validations" do
    it "is valid with a name and user" do
      watch_list = build(:watch_list)
      expect(watch_list).to be_valid
    end

    it "is invalid without a name" do
      watch_list = build(:watch_list, name: nil)
      expect(watch_list).not_to be_valid
    end

    it "is invalid with name over 50 characters" do
      watch_list = build(:watch_list, name: "a" * 51)
      expect(watch_list).not_to be_valid
    end

    it "is invalid when user already has 10 lists" do
      user = create(:user)
      create_list(:watch_list, 10, user: user)
      extra = build(:watch_list, user: user)
      expect(extra).not_to be_valid
    end

    it "is valid when user has fewer than 10 lists" do
      user = create(:user)
      create_list(:watch_list, 9, user: user)
      extra = build(:watch_list, user: user)
      expect(extra).to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      watch_list = create(:watch_list)
      expect(watch_list.user).to be_a(User)
    end

    it "nullifies user_items watch_list_id when deleted" do
      user = create(:user)
      watch_list = create(:watch_list, user: user)
      movie = create(:movie, user: user)
      user_item = create(:user_item, user: user, itemable: movie, watch_list: watch_list)
      watch_list.destroy
      expect(user_item.reload.watch_list_id).to be_nil
    end
  end
end
