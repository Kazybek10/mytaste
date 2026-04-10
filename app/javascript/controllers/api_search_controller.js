import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "spinner"]

  static values = {
    searchUrl: String,
    importUrl: String,
    idParam: String
  }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      this.resultsTarget.classList.remove("active")
      return
    }

    this.timeout = setTimeout(() => this.fetchResults(query), 400)
  }

  async fetchResults(query) {
    this.spinnerTarget.classList.add("active")

    try {
      const res = await fetch(`${this.searchUrlValue}?query=${encodeURIComponent(query)}`)
      const data = await res.json()
      this.renderResults(data)
    } catch (e) {
      console.error("API search error:", e)
    } finally {
      this.spinnerTarget.classList.remove("active")
    }
  }

  renderResults(items) {
    if (!items.length) {
      this.resultsTarget.innerHTML = `<div class="api-no-results">Nothing found</div>`
      this.resultsTarget.classList.add("active")
      return
    }

    this.resultsTarget.innerHTML = items.map(item => {
      const id = item.tmdb_id || item.ol_key || item.meal_id
      const poster = item.poster_url || item.cover_url
      const year = item.release_year || item.publish_year || item.category || ""

      return `
        <div class="api-result-item" data-id="${id}">
          ${poster
            ? `<img src="${poster}" class="api-result-poster" />`
            : `<div class="api-result-poster-blank"></div>`
          }
          <div class="api-result-info">
            <p class="api-result-title">${item.title}</p>
            <p class="api-result-meta">${year}</p>
          </div>
        </div>
      `
    }).join("")

    this.resultsTarget.classList.add("active")

    this.resultsTarget.querySelectorAll(".api-result-item").forEach(el => {
      el.addEventListener("click", () => this.importItem(el.dataset.id))
    })
  }

  // Переходим на страницу api_import — Rails создаст запись и сделает redirect на show
  importItem(id) {
    const url = `${this.importUrlValue}?${this.idParamValue}=${encodeURIComponent(id)}`
    window.location.href = url
  }

  closeResults() {
    setTimeout(() => this.resultsTarget.classList.remove("active"), 200)
  }
}
