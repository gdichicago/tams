class Course < ApplicationRecord
  before_validation :format_pretty_dates

  has_many :hours, dependent: :destroy
  has_many :teaching_assistants, through: :hours

  validates_presence_of :credit_hours, :num_tas_needed, :name, :date, :url, :location, :start_time, :end_time, :pretty_time, :pretty_date

  scope :upcoming, -> { where("date > ?", Date.yesterday) }
  scope :past, -> { where("date < ?", Date.today) }

  def ta_emails
    teaching_assistants.map { |ta| ta.email }.join(',')
  end

  def hour_for(teaching_assistant)
    hours.where(teaching_assistant: teaching_assistant).first
  end

  def is_past?
    date < Date.today
  end

  def need_tas?
    num_tas_still_needed > 0
  end

  def num_tas_still_needed
    count = num_tas_needed - num_tas
    return 0 unless count > 0
    count
  end

  def num_tas
    teaching_assistants.select { |ta| ta.is_ta_for?(self) }.length
  end

  def pretty_date_short
    date.strftime("%B %e, %Y")
  end

  private
  def format_pretty_dates
    self.pretty_date = self.date.strftime("%B %e, %Y (%A)")
    self.pretty_time = "#{self.start_time.strftime("%I:%M %p")}–#{self.end_time.strftime("%I:%M %p")}"
  end
end
