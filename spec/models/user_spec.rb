require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with email and password" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with duplicate email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end
  end

  describe "#display_name" do
    it "returns username when set" do
      user = build(:user, username: "kazybek")
      expect(user.display_name).to eq("kazybek")
    end

    it "returns email prefix when no username" do
      user = build(:user, email: "kazybek@gmail.com", username: nil)
      expect(user.display_name).to eq("kazybek")
    end
  end

  describe "associations" do
    it "has many user_items" do
      user = create(:user)
      movie = create(:movie, user: user)
      create(:user_item, user: user, itemable: movie)
      expect(user.user_items.count).to eq(1)
    end

    it "has many watch_lists" do
      user = create(:user)
      create(:watch_list, user: user)
      expect(user.watch_lists.count).to eq(1)
    end

    it "destroys user_items when user is deleted" do
      user = create(:user)
      movie = create(:movie, user: user)
      create(:user_item, user: user, itemable: movie)
      expect { user.destroy }.to change(UserItem, :count).by(-1)
    end
  end
end
