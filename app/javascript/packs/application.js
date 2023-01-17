// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
require("trix")
require("@rails/actiontext")
import Trix from "trix";

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

// Trix.config.textAttributes.underline = {
//   style: { "textDecoration": "underline" },
//   inheritable: true,
//   parser: function (element) {
//       var style = window.getComputedStyle(element);
//       return style.textDecoration === "underline";
//   }
// }

// document.addEventListener('trix-initialize', function (e) {
//   const trix = e.target;
//   const toolBar = trix.toolbarElement;

//   // // Creation of the button
//   const button = document.createElement("button");
//   button.setAttribute("type", "button");
//   button.setAttribute("class", "trix-button trix-button--icon trix-button--icon-underline");
//   button.setAttribute("data-trix-attribute", "underline");
//   button.setAttribute("title", "underline");
//   button.setAttribute("tabindex", "-1");
//   button.innerText = "U";

//   // Attachment of the button to the toolBar
//   const uploadButton = toolBar.querySelector('.trix-button-group--text-tools').appendChild(button);
// });
