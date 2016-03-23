class Group < ActiveRecord::Base
  validates :name, presence: true

  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :organization

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
end
