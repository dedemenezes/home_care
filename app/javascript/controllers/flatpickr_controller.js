import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ['input']
  connect() {
    console.log('bora flatpickr!');
    this.fp = flatpickr(this.inputTarget, {
      dateFormat: "Y-m-d H:i"
      , maxTime: "22:00"
      , time_24hr: true
      , minTime: "08:00"
      , altInput: true
      , altFormat: "F j, Y at H:00"
      , enableTime: true
    })
  }
}
