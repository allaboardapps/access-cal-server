class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :region_id, presence: true

  belongs_to :region
  has_many :events
end
