class GroupUser < ActiveRecord::Base
  include Activatable

  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :group
  belongs_to :user
end
