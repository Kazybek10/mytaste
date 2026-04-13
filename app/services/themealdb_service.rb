require "net/http"
require "json"

class ThemealdbService
  BASE_URL = "https://www.themealdb.com/api/json/v1/1"

  def self.search(query)
    uri = URI("#{BASE_URL}/search.php?s=#{URI.encode_www_form_component(query)}")
    response = make_request(uri)
    return [] unless response && response["meals"]

    response["meals"].first(8).map do |meal|
      {
        meal_id:      meal["idMeal"],
        title:        meal["strMeal"],
        category:     meal["strCategory"],
        poster_url:   meal["strMealThumb"]
      }
    end
  end

  def self.find(meal_id)
    uri = URI("#{BASE_URL}/lookup.php?i=#{meal_id}")
    response = make_request(uri)
    return nil unless response && response["meals"]

    meal = response["meals"].first

    ingredients = (1..20).filter_map do |i|
      ingredient = meal["strIngredient#{i}"]
      measure    = meal["strMeasure#{i}"]
      next if ingredient.blank?
      "#{measure&.strip} #{ingredient.strip}".strip
    end.join(", ")

    {
      title:        meal["strMeal"],
      ingredients:  ingredients,
      instructions: meal["strInstructions"]&.truncate(5000),
      poster_url:   meal["strMealThumb"]
    }
  end

  private

  def self.make_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.get(uri.request_uri)
    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "TheMealDB API error: #{e.message}"
    nil
  end
end
