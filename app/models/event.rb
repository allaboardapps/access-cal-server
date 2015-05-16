class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  belongs_to :location
  has_one :region, through: :loca
end
