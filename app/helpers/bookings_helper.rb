module BookingsHelper
  def time_options(service_duration = 0)
    start_time = Time.new(2000, 1, 1, 8, 0, 0)  # 8 AM
    closing_time = Time.new(2000, 1, 1, 17, 0, 0) # 5 PM
    latest_start = closing_time - service_duration.minutes

    options = []
    current_time = start_time

    while current_time <= latest_start
      options << [current_time.strftime("%H:%M"), current_time.strftime("%H:%M")]
      current_time += 30.minutes
    end

    options
  end
end
