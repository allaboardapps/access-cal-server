class Region < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  has_many :locations
  has_many :events, through: :locations

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
