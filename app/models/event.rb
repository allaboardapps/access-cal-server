class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  belongs_to :location
  has_one :region, through: :location
  has_many :favorites
  has_many :users, through: :favorites
end
