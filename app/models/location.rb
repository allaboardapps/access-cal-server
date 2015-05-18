class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :region_id, presence: true

  belongs_to :region
  has_many :events

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
