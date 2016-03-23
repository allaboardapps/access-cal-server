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

  def self.execute(creator, loggable, action)
    log = create(
      creator: creator,
      loggable: loggable,
      activity_action_type: action
    )
    log.save
  end
end
