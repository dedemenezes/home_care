import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["street", "streetWrapper", "city", "state", "country"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "address"
    })
    this.geocoder.addTo(this.streetWrapperTarget)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    const [street, neighborhood, city, ziCode, country] = event.result['place_name'].split(',');
    console.log(street);
    console.log(neighborhood);
    console.log(city);
    console.log(event.result);

    this.streetTarget.value = street
    this.cityTarget.value = city.split('-')[0]
    this.stateTarget.value = city.split('-')[1]
    this.countryTarget.value = country

  }

  #clearInputValue() {
    this.streetTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
