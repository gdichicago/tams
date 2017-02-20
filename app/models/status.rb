class Status < ApplicationRecord
  has_many :teaching_assistants

  validates_presence_of :label

  def self.inelligible_statuses
    Status.where(label: %w(banned inactive))
  end
end
