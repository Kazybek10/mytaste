// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { mountStarRating } from "components/star_rating"

window.mountStarRating = mountStarRating

document.addEventListener("turbo:load", () => {
  mountStarRating()
})
