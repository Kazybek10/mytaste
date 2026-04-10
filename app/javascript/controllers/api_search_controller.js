import { Controller } from "@hotwired/stimulus"

// Этот контроллер управляет поиском по внешнему API (TMDB / Open Library / TheMealDB)
// и автозаполнением формы результатами.

export default class extends Controller {
  static targets = [
    "input", "results", "spinner",
    // Поля формы которые нужно заполнить
    "fieldTitle", "fieldDescription", "fieldYear",
    "fieldDirector", "fieldAuthor", "fieldGenre",
    "fieldIngredients", "fieldInstructions",
    "posterPreview"
  ]

  static values = {
    searchUrl: String,   // URL для поиска (/movies/api_search)
    importUrl: String,   // URL для получения деталей (/movies/api_import)
    idParam: String      // имя параметра id (tmdb_id / ol_key / meal_id)
  }

  connect() {
    this.timeout = null
  }

  // Вызывается при вводе текста — ждёт 400мс после последнего нажатия
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

    this.resultsTarget.innerHTML = items.map(item => `
      <div class="api-result-item" data-id="${item.tmdb_id || item.ol_key || item.meal_id}">
        ${item.poster_url || item.cover_url
          ? `<img src="${item.poster_url || item.cover_url}" class="api-result-poster" />`
          : `<div class="api-result-poster-blank"></div>`
        }
        <div class="api-result-info">
          <p class="api-result-title">${item.title}</p>
          <p class="api-result-meta">${item.release_year || item.publish_year || item.category || ""}</p>
        </div>
      </div>
    `).join("")

    this.resultsTarget.classList.add("active")

    // Клик по результату — загружаем детали и заполняем форму
    this.resultsTarget.querySelectorAll(".api-result-item").forEach(el => {
      el.addEventListener("click", () => this.importItem(el.dataset.id, items.find(i =>
        String(i.tmdb_id || i.ol_key || i.meal_id) === el.dataset.id
      )))
    })
  }

  async importItem(id, basicData) {
    // Сразу заполняем базовые поля пока грузим детали
    this.fillField("fieldTitle", basicData.title)
    this.fillField("fieldYear", basicData.release_year || basicData.publish_year)
    this.fillField("fieldAuthor", basicData.author)
    this.fillField("fieldGenre", basicData.genre || basicData.category)

    // Показываем постер превью
    const posterUrl = basicData.poster_url || basicData.cover_url
    if (posterUrl && this.hasPosterPreviewTarget) {
      this.posterPreviewTarget.src = posterUrl
      this.posterPreviewTarget.style.display = "block"
    }

    // Закрываем дропдаун
    this.resultsTarget.classList.remove("active")
    this.inputTarget.value = basicData.title

    // Загружаем полные детали
    try {
      const params = `${this.idParamValue}=${encodeURIComponent(id)}`
      const res = await fetch(`${this.importUrlValue}?${params}`)
      const data = await res.json()
      if (!data) return

      this.fillField("fieldTitle", data.title)
      this.fillField("fieldDescription", data.description)
      this.fillField("fieldYear", data.release_year || data.publish_year)
      this.fillField("fieldDirector", data.director)
      this.fillField("fieldAuthor", data.author)
      this.fillField("fieldGenre", data.genre)
      this.fillField("fieldIngredients", data.ingredients)
      this.fillField("fieldInstructions", data.instructions)
    } catch (e) {
      console.error("API import error:", e)
    }
  }

  fillField(targetName, value) {
    const targetMethod = `has${targetName.charAt(0).toUpperCase() + targetName.slice(1)}Target`
    if (this[targetMethod] && value) {
      this[`${targetName}Target`].value = value
    }
  }

  // Закрыть дропдаун при клике вне
  closeResults() {
    setTimeout(() => this.resultsTarget.classList.remove("active"), 200)
  }
}
