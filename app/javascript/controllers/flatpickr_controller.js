import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    // console.log("connected", this.element);

    flatpickr('.booking_date', {
      dateFormat: "d-m-Y",
      minDate: "today",
    });

    flatpickr('.booking_time', {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true,
      minuteIncrement: 30,
    });
  }
}
