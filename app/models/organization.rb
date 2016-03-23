class Organization < ActiveRecord::Base
  validates :name, presence: true

  has_many :organization_users
  has_many :users, through: :organization_users

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
end
