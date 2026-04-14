import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "actions"]

  edit() {
    this.displayTarget.classList.add("hidden")
    this.actionsTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.formTarget.querySelector("input")?.focus()
  }

  cancel() {
    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")
    this.actionsTarget.classList.remove("hidden")
  }
}
