class OrganizationUser < ActiveRecord::Base
  include Activatable

  validates :organization_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :organization
  belongs_to :user
end
