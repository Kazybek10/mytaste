require "rails_helper"

RSpec.describe UserItem, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie, user: user) }

  describe "validations" do
    it "is valid with valid attributes" do
      user_item = build(:user_item, user: user, itemable: movie, status: "want")
      expect(user_item).to be_valid
    end

    it "is invalid with an invalid status" do
      user_item = build(:user_item, user: user, itemable: movie, status: "invalid")
      expect(user_item).not_to be_valid
    end

    it "is invalid with a rating outside 1-5" do
      user_item = build(:user_item, user: user, itemable: movie, rating: 6)
      expect(user_item).not_to be_valid
    end

    it "is valid with a nil rating" do
      user_item = build(:user_item, user: user, itemable: movie, rating: nil)
      expect(user_item).to be_valid
    end

    it "is invalid if user already has this item" do
      create(:user_item, user: user, itemable: movie)
      duplicate = build(:user_item, user: user, itemable: movie)
      expect(duplicate).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      expect(UserItem.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to itemable polymorphically" do
      expect(UserItem.reflect_on_association(:itemable).macro).to eq(:belongs_to)
    end
  end
end
