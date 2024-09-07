# Pin npm packages by running ./bin/importmap
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js", preload: true
pin "flowbite", to: "https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.turbo.min.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.3/app/assets/javascripts/rails-ujs.esm.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/channels", under: "channels"

pin "application"
pin "lucide" # @0.433.0
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
