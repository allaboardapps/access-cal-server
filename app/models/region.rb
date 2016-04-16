class Region < ActiveRecord::Base
  include Activatable

  validates :name, presence: true
  validates :abbreviation, presence: true

  has_many :locations
  has_many :events, through: :locations

  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
