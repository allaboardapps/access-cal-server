class Favorite < ActiveRecord::Base
  include Activatable

  validates :user_id, presence: true
  validates :event_id, presence: true

  belongs_to :user
  belongs_to :event
end
