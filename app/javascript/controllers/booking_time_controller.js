import { Controller } from "@hotwired/stimulus"
import { DateTime, Duration } from "https://cdn.skypack.dev/luxon"

export default class extends Controller {
  static targets = ["timeSlots"]
  static values = { duration: Number }

  connect() {
    this.timeSlotsTarget.classList.add("hidden")
    this.selectedSlot = null  // Track the currently selected slot

    // Listen to the change event on the date input
    const dateInput = document.querySelector('[data-controller="flatpickr"]')
    if (dateInput) {
      dateInput.addEventListener("change", (event) => {
        this.showTimeSlots(event.target.value)
      })
    }
  }

  showTimeSlots(selectedDate) {
    this.timeSlotsTarget.classList.remove("hidden");

    // Make the fetch request to the backend to get unavailable times
    fetch(`/bookings/unavailable_times?date=${selectedDate}`)
      .then(response => response.json()) // Parse JSON response
      .then(data => {
        if (data && data.unavailable) {
          this.updateTimeSlots(data.unavailable);
        }
      })
      .catch(error => {
        console.error("Error fetching unavailable times:", error);
      });
  }

  // This function will update the available time slots based on the unavailable ones
  updateTimeSlots(unavailableTimes) {
    const startHour = 8;
    const endHour = 17; // closing time
    const duration = Duration.fromObject({ minutes: this.durationValue });

    const container = this.timeSlotsTarget;
    container.innerHTML = ""; // Clear existing slots

    const closingTime = DateTime.fromObject({ hour: endHour, minute: 0 });

    let lastEndTime = DateTime.fromObject({ hour: startHour, minute: 0 });

    // Go through all the available time slots and hide the ones that are unavailable
    for (let hour = startHour; hour < endHour; hour++) {
      for (let minute of [0, 30]) {
        const time = DateTime.fromObject({ hour, minute });
        const endTime = time.plus(duration);

        // Skip if booking would end after closing
        if (endTime > closingTime) continue;

        const timeStr = time.toFormat("HH:mm");

        // Check if this time slot is unavailable
        const isUnavailable = unavailableTimes.some(slot => {
          const slotStart = DateTime.fromFormat(slot.start, "HH:mm");
          const slotEnd = DateTime.fromFormat(slot.end, "HH:mm");

          return time >= slotStart && time < slotEnd;
        });

        // Skip this slot if it's already blocked by previous service duration
        if (time < lastEndTime) {
          continue;
        }

        // Find the next available time slot based on the service duration
        const serviceDuration = Duration.fromObject({ minutes: unavailableTimes.find(slot => slot.start === timeStr)?.duration || 0 });
        lastEndTime = time.plus(serviceDuration);

        const id = `time_${timeStr.replace(":", "")}`;

        const slotHTML = `
          <div class="time-slot ${isUnavailable ? 'unavailable' : ''}">
            <input type="radio" name="booking[booking_time]" value="${timeStr}" id="${id}" class="time-slot-input" ${isUnavailable ? 'disabled' : ''}>
            <label for="${id}" class="time-slot-label">
              <span class="time-slot-circle"></span>
              <span class="time-slot-text">${timeStr}</span>
            </label>
            <!-- Placeholder for "Finishes at" -->
            <div class="finishes-at hidden" id="finishes_at_${id}"></div>
          </div>
        `;

        container.insertAdjacentHTML("beforeend", slotHTML);
      }
    }

    // Attach event listeners to each time slot
    const timeSlotInputs = container.querySelectorAll('.time-slot-input');
    timeSlotInputs.forEach(input => {
      input.addEventListener('change', (event) => {
        this.handleTimeSlotSelection(event.target);
      });
    });
  }

  handleTimeSlotSelection(selectedInput) {
    const selectedTimeStr = selectedInput.value;
    const selectedTime = DateTime.fromFormat(selectedTimeStr, "HH:mm");
    const duration = Duration.fromObject({ minutes: this.durationValue });
    const finishTime = selectedTime.plus(duration).toFormat("HH:mm");

    // Hide the "finishes at" for the previous selected time slot (if any)
    if (this.selectedSlot) {
      const prevSlotFinishesAt = document.getElementById(`finishes_at_${this.selectedSlot.id}`);
      if (prevSlotFinishesAt) {
        prevSlotFinishesAt.classList.add('hidden');
      }
    }

    // Show the "finishes at" for the newly selected time slot
    const finishesAtElement = document.getElementById(`finishes_at_${selectedInput.id}`);
    if (finishesAtElement) {
      finishesAtElement.textContent = `Finishes at: ${finishTime}`;
      finishesAtElement.classList.remove('hidden');
    }

    // Update the currently selected slot
    this.selectedSlot = selectedInput;
  }
}
