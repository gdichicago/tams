module HoursHelper
  def build_hour_from(hour)
    return false if hour.teaching_assistant.banned?
    if !hour.teaching_assistant.approved?
      hour.num = 0
    else
      hour.num = hour.course.credit_hours
    end
    hour.save
  end
end
