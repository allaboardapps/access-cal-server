class EventTag < ActiveRecord::Base
  validates :event_id, presence: true
  validates :tag_id, presence: true

  belongs_to :tag
  belongs_to :event

  after_save :index_event

  private

  def index_event
    self.event.reload.__elasticsearch__.index_document
  end
end
