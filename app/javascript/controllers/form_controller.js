import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['submit', 'option']
  connect() {
    console.log('connected');
  }

  submitWithKeyboard(event) {
    console.log(this.element.action);
    if (['a', 's', 'd', 'f'].includes(event.key)) {
      switch(event.key) {
        case 'a':
          this.optionTargets[0].checked = true
          this.submitOption()
          break
        case 's':
          console.log('sumit option b')
          break
        case 'd':
          console.log('sumit option c')
          break
        case 'f':
          console.log('sumit option d')
          break
        default:
          console.log(`sorry, we are out of ${event.key}`);
      }
    }
  }

  submitOption(option) {
    fetch(this.element.action, {
      method: 'POST',
      headers: { "Accept": "text/plain" },
      body: new FormData(this.element)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data);

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
