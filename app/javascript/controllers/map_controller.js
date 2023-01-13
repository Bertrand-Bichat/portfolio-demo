import { Controller } from "stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import MapboxLanguage from '@mapbox/mapbox-gl-language';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const language = new MapboxLanguage();

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/eveuuh/ck82ukg8v27lu1inubx72v0wo/draft"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                        mapboxgl: mapboxgl }))
    this.map.addControl(language);
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
