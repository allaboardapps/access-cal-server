class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :region_id, presence: true

  belongs_to :region
  has_many :events

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
