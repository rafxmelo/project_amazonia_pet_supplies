// Initialize Quill editor for ActiveAdmin
document.addEventListener("DOMContentLoaded", function() {
  var editors = document.querySelectorAll(".quill-editor");
  editors.forEach(function(editor) {
    new Quill(editor, {
      theme: "snow"
    });
  });
});
