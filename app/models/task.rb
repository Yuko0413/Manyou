class Task < ApplicationRecord

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  scope :sorted_by_created_at, -> { order(created_at: :desc) }
  scope :sorted_by_deadline, -> { order(deadline_on: :asc) }
  scope :sorted_by_priority, -> { order(priority: :desc) }
  scope :with_status, ->(status) { where(status: status) if status.present? }
  scope :with_title, ->(title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :with_label, ->(label) { joins(:labels).where(labels: { id: label }) if label.present? }


  def display_priority
    I18n.t("enums.task.priority.#{priority}")
  end

  def display_status
    I18n.t("enums.task.status.#{status}")
  end

  def complete!
    update(status: 'completed', completed_at: Time.current)
  end
end
