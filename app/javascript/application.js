import "@hotwired/turbo-rails"
import "controllers"
import Quill from "quill"

import Rails from "@rails/ujs"
Rails.start()

document.addEventListener("turbo:load", () => {
  const quillEditor = document.querySelector(".quill-editor")
  if (quillEditor) {
    new Quill(quillEditor, {
      theme: "snow",
    })
  }
})