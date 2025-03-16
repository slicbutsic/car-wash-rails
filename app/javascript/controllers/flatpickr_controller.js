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

    // Calculate the latest possible booking start time based on service duration
    const maxTime = this.calculateMaxTime()

    flatpickr(this.element, {
      enableTime: true,
      dateFormat: "d-m-Y H:i",
      minDate: this.getMinDate(now).toJSDate(),
      minTime: this.getMinTime(now),
      maxTime: maxTime,
      minuteIncrement: 30,
      time_24hr: true
    })
  }

  getMinDate(now) {
    // If it's after 5 PM, set minimum date to the next day
    return now.hour >= 17 ? now.plus({ days: 1 }).startOf("day") : now
  }

  getMinTime(now) {
    // If it's after 5 PM, reset time to 8 AM for the next day
    return now.hour >= 17 ? "08:00" : `${Math.max(now.hour, 8)}:${now.minute}`
  }

  calculateMaxTime() {
    const closingHour = 17 // Business closes at 5 PM
    const maxEndTime = DateTime.now().set({ hour: closingHour, minute: 0 }) // Closing time in Brisbane timezone

    // Subtract service duration from closing time to get latest possible start time
    const latestStartTime = maxEndTime.minus({ minutes: this.durationValue })
    return latestStartTime.toFormat("HH:mm") // Format as "HH:mm" for Flatpickr
  }
}
