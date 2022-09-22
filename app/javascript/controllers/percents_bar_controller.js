import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="percents-bar"
export default class extends Controller {
  static values = {
    percent: Number
  }
  static targets = ['fill', 'span']

  connect() {
    const deg = 360 * this.percentValue / 100;
    if (this.percentValue > 50) {
      this.element.classList.add('gt-50');
    }
    this.fillTarget.style.transform = `rotate(${deg}deg)`
    this.spanTarget.innerText = `${this.percentValue}%`
  }
}
