ActiveAdmin.register Activity do
  menu parent: "Reports", priority: 5

  actions :all, except: [:edit, :destroy]

  config.sort_order = "created_at_desc"

  filter :loggable_type
  filter :activity_action_type, as: :select, collection: ActivityActionTypes.all
  filter :creator_last_name_contains, as: :string
  filter :description_contains, as: :string

  index do
    column :id
    column "User", :creator
    column "Role" do |activity_log|
      activity_log.creator.roles.join(",")
    end
    column "Action", :activity_action_type
    column "Entity", :loggable_type
    column "Entity Name", :loggable
    column "Created", sortable: "areas.created_at" do |activity_log|
      activity_log.created_at
    end
    actions
  end

  show do |activity_log|
    attributes_table do
      row :id
      row :creator
      row "Loggable" do
        loggable if activity_log.loggable.present?
      end
      row :loggable_type
      row :activity_action_type
      row :description
      row "Explanation" do
        activity_log.explanation if activity_log.loggable.present?
      end
      row :updated_at
      row :created_at
    end
  end
end
