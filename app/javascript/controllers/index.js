// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import FlatpickrController from "controllers/flatpickr_controller"
import BookingTimeController from "controllers/booking_time_controller"

application.register("flatpickr", FlatpickrController)
application.register("booking_time", BookingTimeController)
