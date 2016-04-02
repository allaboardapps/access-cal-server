class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :tag_type, presence: true

  has_many :event_tags
  has_many :events, through: :event_tags
end
