class Location < ActiveRecord::Base
  include Activatable

  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :region_id, presence: true

  belongs_to :region
  has_many :events

  scope :autocomplete, -> (query) { active.where("name ilike ?", "#{query}%").order(name: :asc) }
end
