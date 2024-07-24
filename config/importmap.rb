# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "quill", to: "https://cdn.quilljs.com/1.3.6/quill.js"
pin "quill.css", to: "https://cdn.quilljs.com/1.3.6/quill.snow.css"
