class Region < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  has_many :locations
  has_many :events, through: :locations
end
