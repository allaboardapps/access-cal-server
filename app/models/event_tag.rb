class EventTag < ActiveRecord::Base
  validates :event_id, presence: true
  validates :tag_id, presence: true

  belongs_to :tag
  belongs_to :event
end
