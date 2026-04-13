require "net/http"
require "json"

class OpenLibraryService
  BASE_URL = "https://openlibrary.org"
  COVER_URL = "https://covers.openlibrary.org/b/id"

  def self.search(query)
    uri = URI("#{BASE_URL}/search.json?q=#{URI.encode_www_form_component(query)}&limit=8&fields=key,title,author_name,first_publish_year,subject,cover_i,first_sentence")
    response = make_request(uri)
    return [] unless response

    response["docs"].map do |book|
      {
        ol_key:       book["key"],
        title:        book["title"],
        author:       book["author_name"]&.first,
        publish_year: book["first_publish_year"],
        genre:        book["subject"]&.first(2)&.join(", "),
        cover_url:    book["cover_i"] ? "#{COVER_URL}/#{book["cover_i"]}-M.jpg" : nil
      }
    end
  end

  def self.find(ol_key)
    uri = URI("#{BASE_URL}#{ol_key}.json")
    response = make_request(uri)
    return nil unless response

    description = response["description"]
    description = description["value"] if description.is_a?(Hash)

    {
      title:       response["title"],
      description: description&.truncate(1000)
    }
  end

  class << self
    private

    def make_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.request_uri)
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.error "OpenLibrary API error: #{e.message}"
      nil
    end
  end
end
