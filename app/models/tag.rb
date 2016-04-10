class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :tag_type, presence: true

  has_many :event_tags
  has_many :events, through: :event_tags

  before_save :downcase_name

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }

  private

  def downcase_name
    name.downcase!
  end
end
