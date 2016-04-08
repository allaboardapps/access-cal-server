class CreateActivityLogJob < ActiveJob::Base
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) do
    retry_job wait: 1.minute, queue: :default
  end

  def perform(creator_id, loggable, action, description)
    creator = User.find_by(id: creator_id)

    Activity.create(
      creator: creator,
      loggable: loggable,
      activity_action_type: action,
      description: description
    )
  end
end
