require "elasticsearch/model"

class Event < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # prevents elastic namespace conflicts between envs
  # https://blog.pivotal.io/labs/labs/rspec-elasticsearchruby-elasticsearchmodel
  index_name [AppSettings.app_repo_name, Rails.env, base_class.to_s.pluralize.underscore].join("_")

  validates :name, presence: true
  validates :time_zone, presence: true

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :location
  belongs_to :calendar
  has_many :activities, as: :loggable
  has_many :event_tags
  has_many :favorites
  has_many :tags, through: :event_tags
  has_many :favorite_users, through: :favorites, source: :user
  has_many :event_users
  has_many :users, through: :event_users
  has_one :region, through: :location

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
  scope :autocomplete, -> (query) { active.where("name ilike ? or abbreviation ilike ?", "#{query}%", "#{query}%").order(name: :asc, abbreviation: :asc) }

  mappings dynamic: "false" do
    indexes :name, analyzer: "snowball"
    indexes :abbreviation, analyzer: "snowball"

    indexes :tags do
      indexes :name, analyzer: "snowball"
    end
  end

  def as_indexed_json(_options = {})
    as_json(
      include: { tags: { only: :name } }
    )
  end

  def self.search_for(*args, &block)
    __elasticsearch__.search(*args, &block)
  end

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end
end
