// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="flatpickr"
// export default class extends Controller {
//   connect() {
//     // console.log("connected", this.element);

//     flatpickr('.booking_date', {
//       dateFormat: "d-m-Y",
//       minDate: "today",
//     });

//     flatpickr('.booking_time', {
//       enableTime: true,
//       noCalendar: true,
//       dateFormat: "H:i",
//       time_24hr: true,
//       minuteIncrement: 30,
//     });
//   }
// }

import { Controller } from "@hotwired/stimulus"
// import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    this.initDatePicker()
    this.initTimePicker()
  }

  initDatePicker() {
    flatpickr('.booking_date', {
      dateFormat: "d-m-Y",
      minDate: "today",
      allowInput: true,
      onClose: (selectedDates, dateStr, instance) => {
        if (dateStr) {
          instance.input.classList.remove('error')
        } else {
          instance.input.classList.add('error')
        }
      }
    });
  }

  initTimePicker() {
    flatpickr('.booking_time', {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true,
      minuteIncrement: 30,
      allowInput: true,
      onClose: (selectedDates, dateStr, instance) => {
        if (dateStr) {
          instance.input.classList.remove('error')
        } else {
          instance.input.classList.add('error')
        }
      }
    });
  }
}
