class Tag < ActiveRecord::Base
  include Activatable

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :tag_type, presence: true

  has_many :event_tags
  has_many :events, through: :event_tags

  before_save :downcase_name

  private

  def downcase_name
    name.downcase!
  end
end
