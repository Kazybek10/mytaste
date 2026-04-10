require "rails_helper"

RSpec.describe Recipe, type: :model do

  describe "validations" do

    it "is valid with all required fields" do
      recipe = build(:recipe)
      expect(recipe).to be_valid
    end

    it "is invalid without a title" do
      recipe = build(:recipe, title: nil)
      expect(recipe).not_to be_valid
    end

    it "is invalid without ingredients" do
      recipe = build(:recipe, ingredients: nil)
      expect(recipe).not_to be_valid
    end

    it "is invalid without instructions" do
      recipe = build(:recipe, instructions: nil)
      expect(recipe).not_to be_valid
    end

    it "is invalid with ingredients shorter than 10 characters" do
      recipe = build(:recipe, ingredients: "salt")
      expect(recipe).not_to be_valid
    end

    it "is invalid with instructions shorter than 20 characters" do
      recipe = build(:recipe, instructions: "Just cook it.")
      expect(recipe).not_to be_valid
    end
  end
end
