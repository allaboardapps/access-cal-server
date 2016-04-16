class EventUser < ActiveRecord::Base
  include Activatable

  validates :event_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :event
  belongs_to :user
end
