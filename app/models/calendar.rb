class Calendar < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :calendar_user
  has_many :users, through: :calendar_user

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
end
