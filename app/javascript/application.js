// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { Application } from "@hotwired/stimulus";
import FlatpickrController from "./controllers/flatpickr_controller.js";
import BookingTimeController from "./controllers/booking_time_controller.js";

const application = Application.start();
application.register("flatpickr", FlatpickrController);
application.register("booking_time", BookingTimeController);


import "mapkick/bundle"
