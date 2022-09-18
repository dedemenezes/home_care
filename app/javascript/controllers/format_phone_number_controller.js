import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="format-phone-number"
export default class extends Controller {
  static targets = ['input', 'errors' ]

  connect() {

  }

  nicely() {
    console.log(this.inputTarget.value)
    const regexForNumber = new RegExp(/^\d/)
    let number = this.inputTarget.value

    if (number.match(regexForNumber)) {
      let cleaned = ('' + number).replace(/\D/g, '')
      const formatRegex = new RegExp(/(^\d{2})(\d{5})(\d{4}$)/) //Filter only numbers from the input


      //Check if the input is of correct length
      let match = cleaned.match(formatRegex)

      if (match) {
        this.inputTarget.value = `(${match[1]}) ${match[2]} - ${match[3]}`
      }

    } else {
      this.inputTarget.value = this.inputTarget.value.replace(/\D/g, '');
      const errorMessage = `Only numbers allowed`
      this.errorsTarget.innerHTML = errorMessage
    }
  }
}
