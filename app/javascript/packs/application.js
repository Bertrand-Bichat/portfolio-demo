// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

window.addEventListener('load', () => {
  if ("serviceWorker" in navigator) {
    navigator.serviceWorker.register('/service-worker.js').then(registration => {
      console.log('ServiceWorker registered: ', registration);

      var serviceWorker;
      if (registration.installing) {
        serviceWorker = registration.installing;
        console.log('Service worker installing.');
      } else if (registration.waiting) {
        serviceWorker = registration.waiting;
        console.log('Service worker installed & waiting.');
      } else if (registration.active) {
        serviceWorker = registration.active;
        console.log('Service worker active.');
      }

      window.Notification.requestPermission().then(permission => {
        if(permission !== 'granted'){
          throw new Error('Permission not granted for Notification');
        }
      });
    }).catch(registrationError => {
      console.log('Service worker registration failed: ', registrationError);
    });
  }
});

// force to reload the page when internet connexion is offline to render the offline page in cache
window.addEventListener('offline', () => {
  window.location.reload();
});
