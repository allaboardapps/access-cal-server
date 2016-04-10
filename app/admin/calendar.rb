ActiveAdmin.register Calendar do
  menu parent: "Events", priority: 100

  actions :all

  permit_params :name, :time_zone, :archived, :test, :dummy

  scope :active, default: true
  scope :archived
  scope :test
  scope :dummy

  config.sort_order = "lower(name) asc"

  filter :name
  filter :time_zone, as: :select, collection: AllowedTimeZones.all

  index do
    column :name
    column :time_zone
    column :updated_at
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :time_zone
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Users" do
      table_for calendar.calendar_users.includes(:user) do |t|
        t.column "ID" do |entity|
          entity.user.id
        end
        t.column "Name" do |entity|
          link_to entity.user.full_name, admin_user_path(id: user.id)
        end
        t.column "role" do |entity|
          entity.role
        end
      end
    end

    panel "Events" do
      table_for calendar.events do |t|
        t.column "ID" do |entity|
          entity.event.id
        end
        t.column "Name" do |entity|
          link_to entity.event.name, admin_event_path(id: entity.event.id)
        end
        t.column "Time Zone" do |entity|
          entity.event.time_zone
        end
      end
    end
  end
end
