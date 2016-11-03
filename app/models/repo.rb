class Repo < ApplicationRecord
  belongs_to :user

  validates :full_name, presence: true
  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  scope :ordered_by_active, -> { order("active desc") }

  def toggle_active
    update_attributes(active: !active?)
  end
end
