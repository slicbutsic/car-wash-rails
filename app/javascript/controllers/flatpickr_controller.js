import { Controller } from "@hotwired/stimulus"
// import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    this.initDatePicker()
  }

  initDatePicker() {
    // Get current Brisbane time
    const brisbaneDate = new Date().toLocaleString("en-US", {
      timeZone: "Australia/Brisbane"
    })
    const now = new Date(brisbaneDate)

    // Calculate minimum date
    const minDate = this.isPastCutoff(now) ? this.getTomorrow(now) : now

    flatpickr('.booking_date', {
      dateFormat: "d-m-Y",
      minDate: minDate,
      allowInput: true
    })
  }

  isPastCutoff(date) {
    return date.getHours() >= 17 // 5 PM Brisbane time
  }

  getTomorrow(date) {
    const tomorrow = new Date(date)
    tomorrow.setDate(tomorrow.getDate() + 1)
    tomorrow.setHours(0, 0, 0, 0) // Reset to midnight
    return tomorrow
  }
}
