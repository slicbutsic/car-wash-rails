import { Controller } from "@hotwired/stimulus"
import { DateTime } from "https://cdn.skypack.dev/luxon";

export default class extends Controller {
  static values = {
    duration: Number // Service duration in minutes
  }

  connect() {
    this.initFlatpickr()
  }

  initFlatpickr() {
    const brisbaneTZ = "Australia/Brisbane"
    const now = DateTime.now().setZone(brisbaneTZ)

    flatpickr(this.element, {
      enableTime: false,  // Only date (no time)
      dateFormat: "d-m-Y",  // Date format
      minDate: this.getMinDate(now).toJSDate(),  // Min date logic (today or tomorrow)

      onChange: (selectedDates, dateStr, instance) => {
        const selectedDate = DateTime.fromJSDate(selectedDates[0]).setZone(brisbaneTZ)

        // Dispatch a custom event with the selected date (in YYYY-MM-DD format)
        this.element.dispatchEvent(new CustomEvent("date-selected", {
          bubbles: true,
          detail: { selectedDate: selectedDate.toISODate() }  // Send the selected date
        }))
      }
    })
  }

  getMinDate(now) {
    // Set minimum date to today, but if the current time is after 5 PM, set it to tomorrow
    return now.startOf('day') // Forces min date to be today
  }
}
