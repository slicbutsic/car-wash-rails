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

    const maxTime = this.calculateMaxTime()

    flatpickr(this.element, {
      enableTime: true,
      dateFormat: "d-m-Y H:i",
      minDate: this.getMinDate(now).toJSDate(),
      minuteIncrement: 30,
      time_24hr: true,
      maxTime: maxTime,

      // Adjust minTime dynamically based on selected date
      onChange: (selectedDates, dateStr, instance) => {
        const selectedDate = DateTime.fromJSDate(selectedDates[0]).setZone(brisbaneTZ)
        instance.set("minTime", this.getMinTime(selectedDate, now))
      }
    })
  }

  getMinDate(now) {
    return now.hour >= 17 ? now.plus({ days: 1 }).startOf("day") : now
  }

  getMinTime(selectedDate, now) {
    const openingTime = "08:00"

    // If the selected date is today, restrict time to now or later
    if (selectedDate.hasSame(now, "day")) {
      return `${Math.max(now.hour, 8)}:${String(now.minute).padStart(2, "0")}`
    }

    // Otherwise, allow booking from opening time
    return openingTime
  }

  calculateMaxTime() {
    const closingHour = 17
    const maxEndTime = DateTime.now().set({ hour: closingHour, minute: 0 })

    const latestStartTime = maxEndTime.minus({ minutes: this.durationValue })
    return latestStartTime.toFormat("HH:mm")
  }
}
