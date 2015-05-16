class Region < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  has_many :locations
end
