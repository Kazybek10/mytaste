import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "dropdown"]

  connect() {
    this.timeout = null
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
  }

  search() {
    clearTimeout(this.timeout)
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.hideDropdown()
      return
    }

    this.timeout = setTimeout(() => {
      fetch(`/search?query=${encodeURIComponent(query)}`, {
        headers: { "Accept": "application/json" }
      })
        .then(r => r.json())
        .then(data => this.renderDropdown(data))
    }, 300)
  }

  renderDropdown(data) {
    const total = data.movies.length + data.books.length + data.recipes.length

    if (total === 0) {
      this.dropdownTarget.innerHTML = `<div class="gs-empty">Nothing found</div>`
      this.showDropdown()
      return
    }

    const sections = [
      { label: "Movies",  items: data.movies  },
      { label: "Books",   items: data.books   },
      { label: "Recipes", items: data.recipes }
    ]

    let html = ""
    sections.forEach(({ label, items }) => {
      if (items.length === 0) return
      html += `<div class="gs-category">${label}</div>`
      items.forEach(item => {
        html += `<a href="${item.url}" class="gs-item" data-turbo="true">${item.title}</a>`
      })
    })

    this.dropdownTarget.innerHTML = html
    this.showDropdown()
  }

  showDropdown() {
    this.dropdownTarget.classList.add("active")
    document.addEventListener("click", this.handleOutsideClick)
  }

  hideDropdown() {
    this.dropdownTarget.classList.remove("active")
    document.removeEventListener("click", this.handleOutsideClick)
  }

  handleOutsideClick(e) {
    if (!this.element.contains(e.target)) {
      this.hideDropdown()
    }
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }
}
