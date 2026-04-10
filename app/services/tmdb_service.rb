require "net/http"
require "json"

class TmdbService
  BASE_URL = "https://api.themoviedb.org/3"
  IMAGE_BASE = "https://image.tmdb.org/t/p/w500"

  def self.search(query)
    uri = URI("#{BASE_URL}/search/movie?query=#{URI.encode_www_form_component(query)}&language=en-US&page=1")
    response = make_request(uri)
    return [] unless response

    response["results"].first(8).map do |movie|
      {
        tmdb_id:      movie["id"],
        title:        movie["title"],
        description:  movie["overview"],
        release_year: movie["release_date"]&.split("-")&.first&.to_i,
        poster_url:   movie["poster_path"] ? "#{IMAGE_BASE}#{movie["poster_path"]}" : nil
      }
    end
  end

  def self.find(tmdb_id)
    uri = URI("#{BASE_URL}/movie/#{tmdb_id}?language=en-US&append_to_response=credits")
    response = make_request(uri)
    return nil unless response

    director = response.dig("credits", "crew")
                       &.find { |c| c["job"] == "Director" }
                       &.dig("name")

    genres = response["genres"]&.map { |g| g["name"] }&.first(2)&.join(", ")

    {
      title:        response["title"],
      description:  response["overview"],
      release_year: response["release_date"]&.split("-")&.first&.to_i,
      director:     director,
      genre:        genres,
      poster_url:   response["poster_path"] ? "#{IMAGE_BASE}#{response["poster_path"]}" : nil
    }
  end

  private

  def self.make_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"
    request["Content-Type"] = "application/json"
    response = http.request(request)
    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "TMDB API error: #{e.message}"
    nil
  end
end
