class Label < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings

  validates :name, presence: true
end
