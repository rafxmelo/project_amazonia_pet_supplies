import "quill/dist/quill.snow.css";
import Quill from "quill";

document.addEventListener("DOMContentLoaded", () => {
  const quillEditor = document.querySelector(".quill-editor");
  if (quillEditor) {
    new Quill(quillEditor, {
      theme: "snow",
    });
  }
});
