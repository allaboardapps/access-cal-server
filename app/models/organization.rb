class Organization < ActiveRecord::Base
  include Activatable

  validates :name, presence: true

  has_many :groups
  has_many :organization_users
  has_many :users, through: :organization_users
end
