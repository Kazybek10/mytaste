require "rails_helper"

RSpec.describe Movie, type: :model do
  describe "validations" do
    it "is valid with all required fields" do
      movie = build(:movie)
      expect(movie).to be_valid
    end

    it "is invalid without a title" do
      movie = build(:movie, title: nil)
      expect(movie).not_to be_valid
    end

    it "is invalid with a title shorter than 2 characters" do
      movie = build(:movie, title: "A")
      expect(movie).not_to be_valid
    end

    it "is invalid without a director" do
      movie = build(:movie, director: nil)
      expect(movie).not_to be_valid
    end

    it "is invalid without a release year" do
      movie = build(:movie, release_year: nil)
      expect(movie).not_to be_valid
    end

    it "is invalid with release year before 1800" do
      movie = build(:movie, release_year: 1799)
      expect(movie).not_to be_valid
    end

    it "is invalid with a description over 1000 characters" do
      movie = build(:movie, description: "a" * 1001)
      expect(movie).not_to be_valid
    end
  end

  describe "scopes" do
    it "recent returns movies ordered by newest first" do
      old_movie = create(:movie, created_at: 1.week.ago)
      new_movie = create(:movie, created_at: Time.current)
      expect(Movie.recent.first).to eq(new_movie)
    end
  end
end
