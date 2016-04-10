class Group < ActiveRecord::Base
  validates :name, presence: true

  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :organization

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
end
