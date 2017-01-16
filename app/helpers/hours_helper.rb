module HoursHelper
  def build_series_hours(series, ta)
    return false if ta.banned?
    courses = series.courses.reject { |c| c.id == params[:course_id] }
    courses.each do |course|
      if course.date > Date.today
        hour = Hour.new(course: course, teaching_assistant: ta)
        build_hour_from(hour)
      end
    end
    return true
  end

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