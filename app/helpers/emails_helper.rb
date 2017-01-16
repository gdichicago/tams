module EmailsHelper
  def update_all_email_flags(course, hours)
    update_course_email_flag(course)
    hours.each { |h| update_hour_email_flag(h) }
  end

  def update_course_email_flag(course)
    course.email_sent = true
    course.save!
  end

  def update_hour_email_flag(hour)
    hour.email_sent = true
    hour.save!
  end
end