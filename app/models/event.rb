class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :primary_category, presence: true

  belongs_to :client, class_name: "User", foreign_key: :client_id
  belongs_to :location
  has_one :region, through: :location
  has_many :favorites
  has_many :users, through: :favorites

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ? or abbreviation ilike ?", "#{query}%", "#{query}%").order(name: :asc, abbreviation: :asc) }
end
