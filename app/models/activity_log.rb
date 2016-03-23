class ActivityLog < ActiveRecord::Base
  validates :creator_id, presence: true
  validates :loggable, presence: true

  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :loggable, polymorphic: true

  scope :creates, -> { where(activity_action_type: ActivityActionTypes::CREATE) }
  scope :updates, -> { where(activity_action_type: ActivityActionTypes::UPDATE) }
  scope :archives, -> { where(activity_action_type: ActivityActionTypes::ARCHIVE) }
  scope :unarchives, -> { where(activity_action_type: ActivityActionTypes::UNARCHIVE) }
  scope :deletes, -> { where(activity_action_type: ActivityActionTypes::DELETE) }

  def self.create(creator, loggable, action, desc = nil)
    ActivityLog.create(
      creator: creator,
      loggable: loggable,
      activity_action_type: action,
      description: desc
    )
  end

  def explanation
    notes = description || "none"
    "#{creator.name} executed a(n) #{activity_action_type.upcase} action on #{loggable_type}: #{loggable.name}, Notes: #{notes}"
  end
end
