// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"



import { Application } from "@hotwired/stimulus";
import FlatpickrController from "./controllers/flatpickr_controller.js";

const application = Application.start();
application.register("flatpickr", FlatpickrController);
