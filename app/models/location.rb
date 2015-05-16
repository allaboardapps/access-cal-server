class Region < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  belongs_to :region
  has_many :events
end
