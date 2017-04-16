class TeachingAssistant < ApplicationRecord
  before_create :generate_private_id

  belongs_to :status
  has_many :hours, dependent: :destroy
  has_many :courses, through: :hours

  validates_uniqueness_of :private_id, :email
  validates_presence_of :name, :email, :status
  validates_format_of :email, with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,}/


  # STATUSES
  scope :approved, -> { where status: Status.find_by_label("approved") }
  scope :pending, -> { where status: Status.find_by_label("pending") }
  scope :banned, -> { where status: Status.find_by_label("banned") }
  scope :prospective, -> { where status: Status.find_by_label("prospective") }

  def self.elligible
    self.where.not(status: [Status.inelligible_statuses])
  end

  def pending?
    status.label == "pending"
  end

  def approved?
    status.label == "approved"
  end

  def banned?
    status.label == "banned"
  end

  def inactive?
    (status.label == "inactive") || (status.label == "banned")
  end

  def prospective?
    status.label == "prospective"
  end

  # BALANCES
  def balance
    return 0 unless approved?
    history.to_a.map(&:num).inject(&:+) || 0
  end


  # SCHEDULING & ATTENDANCE
  def history
    hours.select { |h| h.course.date < Date.tomorrow }.sort_by { |h| h.course.date }
  end

  def schedule
    hours.where('num >= 0').select { |h| h.course.date > Date.yesterday }.map(&:course).sort_by(&:date)
  end

  def is_ta_for?(course)
    hours.credit.where(course: course).present?
  end

  private
  def generate_private_id
    self.private_id = SecureRandom.hex
  end
end
