class Status < ApplicationRecord
  has_many :teaching_assistants

  validates_presence_of :label

  def self.inelligible_statuses
    where(label: %w(banned inactive prospective))
  end

  def self.pending
    find_by_label('pending')
  end

  def self.inactive
    find_by_label('inactive')
  end

  def color
    case self.label
    when 'prospective', 'pending'
      'amber lighten-1'
    when 'approved'
      'teal lighten-2'
    else
      'red lighten-2'
    end
  end

  def upgrade
    case self.label
    when 'pending', 'approved'
      Status.find_by_label('approved')
    else
      Status.find_by_label('pending')
    end
  end

  def downgrade
    case self.label
    when 'approved'
      Status.find_by_label('pending')
    else
      Status.find_by_label('banned')
    end
  end
end
