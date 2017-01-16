module ApplicationHelper
  def set_resources
    @courses = Course.upcoming.includes(:series).sort_by(&:date)
    @series = Series.all.sort_by(&:end_date)
    @tas = TeachingAssistant.active.sort_by(&:name)
    @approved = Status.find_by_label("approved")
    @pending = Status.find_by_label("pending")
    @prospective = Status.find_by_label("prospective")
    @banned = Status.find_by_label("banned")
    @inactive = Status.find_by_label("inactive")
  end
end
