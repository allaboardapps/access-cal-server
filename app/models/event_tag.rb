class EventTag < ActiveRecord::Base
  validates :event_id, presence: true
  validates :tag_id, presence: true

  belongs_to :tag
  belongs_to :event

  after_save :index_event
  after_destroy :index_event

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }

  private

  def index_event
    event.reload.__elasticsearch__.index_document
  end
end
