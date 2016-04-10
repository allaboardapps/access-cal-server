ActiveAdmin.register Calendar do
  menu parent: "Events", priority: 100

  actions :all

  permit_params :name, :time_zone, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

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
        t.column "Name" do |entity|
          link_to entity.user.full_name, admin_user_path(id: entity.user.id)
        end
        t.column "role" do |entity|
          entity.role
        end
      end
    end

    panel "Events" do
      table_for calendar.events.order("events.starts_at ASC") do |t|
        t.column "Name" do |entity|
          link_to entity.name, admin_event_path(id: entity.id)
        end
        t.column "Start Date" do |entity|
          entity.starts_at
        end
        t.column "Time Zone" do |entity|
          entity.time_zone
        end
      end
    end
  end
end
