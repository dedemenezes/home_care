import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['form', 'submit', 'option']
  connect() {
    console.log('connected');
  }

  submitWithKeyboard(event) {
    // console.log(this.element.action);
    if (['a', 's', 'd', 'f'].includes(event.key)) {
      switch(event.key) {
        case 'a':
          this.optionTargets[0].checked = true
          this.submitOption()
          break
        case 's':
          this.optionTargets[1].checked = true
          this.submitOption()
          break
        case 'd':
          this.optionTargets[2].checked = true
          this.submitOption()
          break
        case 'f':
          this.optionTargets[3].checked = true
          this.submitOption()
          break
        default:
          console.log(`sorry, we are out of ${event.key}`);
      }
    }
  }

  submitOption(option) {
    fetch(this.formTarget.action, {
      method: 'POST',
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data);
        this.element.outerHTML = data
      })
  }
//   switch(expr) {
  //   case 'Oranges':
  //     console.log('Oranges are $0.59 a pound.');
  //     break;
  //   case 'Mangoes':
  //   case 'Papayas':
  //     console.log('Mangoes and papayas are $2.79 a pound.');
  //     // expected output: "Mangoes and papayas are $2.79 a pound."
  //     break;
  //   default:
  //     console.log(`Sorry, we are out of ${expr}.`);
  // }

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
