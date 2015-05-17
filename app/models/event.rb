class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true

  belongs_to :location
  belongs_to :client, class_name: "User", foreign_key: :client_id
  has_one :region, through: :location
  has_many :favorites
  has_many :customers, through: :favorites
end
