import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['submit']
  connect() {
  }

  nextInput(event) {
    const isDigitRegex = new RegExp(/\d{1}/)
    this.outerDiv = event.currentTarget.parentElement
    if (isDigitRegex.test(event.currentTarget.value)) {
      if(this.isLastInputField()) {

        this.submitTarget.focus()
      } else {
        this.outerDiv.nextElementSibling.firstElementChild.focus()
      }
    }
  }

  isLastInputField() {
    return this.outerDiv.nextElementSibling === this.submitTarget
  }
}
