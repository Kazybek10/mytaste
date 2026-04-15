import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { messages: Object }

  connect() {
    Object.entries(this.messagesValue).forEach(([type, msg]) => {
      this.show(msg, type)
    })
  }

  show(msg, type = "notice") {
    const toast = document.createElement("div")
    toast.className = `toast toast-${type === "notice" ? "success" : "error"}`
    toast.textContent = msg
    this.element.appendChild(toast)

    requestAnimationFrame(() => toast.classList.add("toast-visible"))

    setTimeout(() => {
      toast.classList.remove("toast-visible")
      toast.addEventListener("transitionend", () => toast.remove())
    }, 3500)
  }
}
