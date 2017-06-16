class TeachingAssistants < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :status_id, presence: true
  validates :private_id, presence: true
end
