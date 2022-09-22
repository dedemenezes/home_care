import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="percents-bar"
export default class extends Controller {
  static values = {
    percent: Number
  }
  static targets = ['fill', 'span']

  connect() {
    this.#updateBar()
  }

  #updateBar () {
    const deg = 360 * this.percentValue / 100;
    if (this.percentValue > 50) {
      this.element.addClass('gt-50');
    }
    this.fillTarget.style.transform = `rotate(${deg}deg)`
    this.spanTarget.innerText = `${this.percentValue}%`
  }
}

// $(function () {
//   var $ppc = $('.progress-pie-chart'),
//     percent = parseInt($ppc.data('percent')),
//     deg = 360 * percent / 100;
//   if (percent > 50) {
//     $ppc.addClass('gt-50');
//   }
//   $('.ppc-progress-fill').css('transform', 'rotate(' + deg + 'deg)');
//   $('.ppc-percents span').html(percent + '%');
// });
