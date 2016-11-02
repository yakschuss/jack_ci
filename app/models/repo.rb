class Repo < ApplicationRecord
  belongs_to :user

  validates :full_name, presence: true
  validates :name, presence: true
end
