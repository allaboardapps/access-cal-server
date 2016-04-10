class Region < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  has_many :locations
  has_many :events, through: :locations

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :dummy, -> { where(dummy: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
