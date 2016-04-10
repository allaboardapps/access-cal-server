class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :tag_type, presence: true

  has_many :event_tags
  has_many :events, through: :event_tags

  before_save :downcase_name

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :dummy, -> { where(dummy: true) }

  private

  def downcase_name
    name.downcase!
  end
end
