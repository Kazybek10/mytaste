import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["box"]

  connect() {
    this.frameLoadHandler = (event) => {
      if (event.target.id === "modal-content") {
        this.element.classList.add("active")
      }
    }
    document.addEventListener("turbo:frame-load", this.frameLoadHandler)

    this.keyHandler = (event) => {
      if (event.key === "Escape") this.close()
    }
    document.addEventListener("keydown", this.keyHandler)
  }

  disconnect() {
    document.removeEventListener("turbo:frame-load", this.frameLoadHandler)
    document.removeEventListener("keydown", this.keyHandler)
  }

  close() {
    this.element.classList.remove("active")
    const frame = document.getElementById("modal-content")
    if (frame) frame.innerHTML = ""
  }

  backdropClick(event) {
    if (!this.boxTarget.contains(event.target)) {
      this.close()
    }
  }
}
