import "quill/dist/quill.snow.css";
import Quill from "quill";
import Rails from "@rails/ujs"
Rails.start()

document.addEventListener("DOMContentLoaded", () => {
  const quillEditor = document.querySelector(".quill-editor");
  if (quillEditor) {
    new Quill(quillEditor, {
      theme: "snow",
    });
  }
});

