import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    console.log("Search controller connected!")
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value.trim()
      const url = `${this.urlValue}?query=${encodeURIComponent(query)}`
      
      console.log("Searching:", url)

      fetch(url, {
        headers: {
          "Accept": "text/html",
          "X-Requested-With": "XMLHttpRequest",
          "X-Search-Request": "true"
        }
      })
      .then(response => response.text())
      .then(html => {
        console.log("Got response!")
        this.resultsTarget.innerHTML = html
      })
    }, 300)
  }
}
