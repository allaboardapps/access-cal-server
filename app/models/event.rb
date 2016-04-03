class Event < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, presence: true
  validates :time_zone, presence: true

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :location
  has_many :activities, as: :loggable
  has_many :event_tags
  has_many :favorites
  has_many :tags, through: :event_tags
  has_many :users, through: :favorites
  has_one :region, through: :location

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ? or abbreviation ilike ?", "#{query}%", "#{query}%").order(name: :asc, abbreviation: :asc) }

  mappings dynamic: 'false' do
    indexes :name, analyzer: 'english'
  end

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end
end

Event.import
