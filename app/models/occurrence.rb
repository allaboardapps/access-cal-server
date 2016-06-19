class Occurrence < ActiveRecord::Base
  include Activatable

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :time_zone, presence: true

  belongs_to :event
end
