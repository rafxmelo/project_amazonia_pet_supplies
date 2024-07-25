import "@hotwired/turbo-rails"
import "controllers"
import Quill from "quill"

document.addEventListener("turbo:load", () => {
  const quillEditor = document.querySelector(".quill-editor")
  if (quillEditor) {
    new Quill(quillEditor, {
      theme: "snow",
    })
  }
})