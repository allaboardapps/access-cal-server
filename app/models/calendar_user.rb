class CalendarUser < ActiveRecord::Base
  include Activatable

  validates :calendar_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :calendar
  belongs_to :user
end
