class Group < ActiveRecord::Base
  include Activatable

  validates :name, presence: true

  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :organization
end
