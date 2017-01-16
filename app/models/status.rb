class Status < ApplicationRecord
  has_many :teaching_assistants

  validates_presence_of :label
end
