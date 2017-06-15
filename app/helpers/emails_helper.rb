module EmailsHelper
  def set_resources
    @courses = Course.upcoming.sort_by(&:date)
    @tas = TeachingAssistant.elligible.sort_by(&:name)
    @approved = Status.find_by_label("approved")
    @pending = Status.find_by_label("pending")
    @prospective = Status.find_by_label("prospective")
    @banned = Status.find_by_label("banned")
    @inactive = Status.find_by_label("inactive")
  end
end
