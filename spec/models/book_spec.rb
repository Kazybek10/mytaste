require "rails_helper"

RSpec.describe Book, type: :model do

  describe "validations" do

    it "is valid with all required fields" do
      book = build(:book)
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = build(:book, title: nil)
      expect(book).not_to be_valid
    end

    it "is invalid without an author" do
      book = build(:book, author: nil)
      expect(book).not_to be_valid
    end

    it "is invalid without a publish year" do
      book = build(:book, publish_year: nil)
      expect(book).not_to be_valid
    end

    it "is invalid with publish year before 1400" do
      book = build(:book, publish_year: 1399)
      expect(book).not_to be_valid
    end

    it "is invalid with a description over 1000 characters" do
      book = build(:book, description: "a" * 1001)
      expect(book).not_to be_valid
    end
  end

  describe "scopes" do

    it "recent returns books ordered by newest first" do
      old_book = create(:book, created_at: 1.week.ago)
      new_book = create(:book, created_at: Time.current)
      expect(Book.recent.first).to eq(new_book)
    end
  end
end
