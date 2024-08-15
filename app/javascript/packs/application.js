// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'
import '@popperjs/core'
import 'jquery'

import Rails from "@rails/ujs";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('DOMContentLoaded', () => {
  console.log("DOM fully loaded and parsed");

  document.querySelectorAll('.task-complete').forEach((checkbox) => {
    checkbox.addEventListener('change', (event) => {
      console.log("Checkbox changed");

      const taskId = event.target.dataset.id;
      const url = event.target.dataset.url;
      console.log("Task ID:", taskId);
      console.log("URL:", url);

      Rails.ajax({
        url: url,
        type: 'PATCH',
        dataType: 'json',
        data: `task[completed]=${event.target.checked}`,
        success: (response) => {
          console.log("Task completed successfully", response);
          document.getElementById(`task-${taskId}`).remove();
        },
        error: (err) => {
          console.error("Failed to complete task", err);
        }
      });
    });
  });
});
