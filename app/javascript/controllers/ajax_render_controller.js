import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ajax-render"
export default class extends Controller {
  static targets = ['container', 'link', 'pagerLight']
  connect() {
  }

  update(event) {
    event.preventDefault()
    // console.log(this.linkTarget.href);
    fetch(this.linkTarget.href, {
      headers: { "Accept": "text/plain" }
    })
      .then(response => response.text())
      .then((data) => {
        if (this.linkTarget.disabled) {
          this.linkTarget.disabled = false
          this.containerTarget.innerHTML = ''
          this.pagerLightTarget.classList.add('d-none')
          this.pagerLightTarget.classList.remove('pager--active')
        } else {
          this.pagerLightTarget.classList.remove('d-none')
          this.pagerLightTarget.classList.add('pager--active')
          this.linkTarget.disabled = true
          this.containerTarget.innerHTML = ''
          this.containerTarget.insertAdjacentHTML('beforeend', data)
        }
      })
  }
}
