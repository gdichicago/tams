class Hour < ApplicationRecord
  belongs_to :teaching_assistant
  belongs_to :course

  validates_presence_of :num, :teaching_assistant, :course

  validates :teaching_assistant, uniqueness: {scope: :course}

  scope :credit, -> { where("num >= ?", 0) }
end
