ActiveAdmin.register User do
  menu parent: "Users", priority: 10

  actions :all

  permit_params(
    :email,
    :first_name,
    :last_name,
    :admin_notes,
    :archived,
    :roles,
    :zip_code,
    :time_zone,
    :archived,
    :test,
    :dummy
  )

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies
  scope :clients
  scope :consumers
  scope :admins

  config.sort_order = "lower(last_name) asc, lower(first_name) asc"

  filter :first_name
  filter :last_name
  filter :email

  index do
    column :first_name
    column :last_name
    column :email do |user|
      mail_to user.email, user.email
    end
    column :roles do |user|
      user.roles_presented
    end
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :admin_notes
      f.input :zip_code
      f.input :archived
      f.input :test
      f.input :dummy
      # f.input :password, hint: "8 alphanumeric characters required"
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :roles do
        user.roles_presented
      end
      row :email do
        mail_to user.email, user.email
      end
      row :admin_notes
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Calendars" do
      table_for user.calendars do |t|
        t.column "Name" do |calendar|
          link_to calendar.name, admin_calendar_path(id: calendar.id)
        end
        t.column "Time Zone" do |calendar|
          calendar.time_zone
        end
      end
    end

    panel "Events" do
      table_for user.events do |t|
        t.column "Name" do |event|
          link_to event.name, admin_event_path(id: event.id)
        end
        t.column "Start Date" do |event|
          event.starts_at
        end
        t.column "Time Zone" do |event|
          event.time_zone
        end
      end
    end

    panel "Organizations" do
      table_for user.organization_users.includes(:organization) do |t|
        t.column "Name" do |entity|
          link_to entity.organization.name, admin_organization_path(id: entity.organization)
        end
        t.column "Role" do |entity|
          entity.role
        end
      end
    end

    panel "Groups" do
      table_for user.group_users.includes(:group) do |t|
        t.column "Name" do |entity|
          link_to entity.group.name, admin_group_path(id: entity.group)
        end
        t.column "Role" do |entity|
          entity.role
        end
      end
    end

    panel "Favorites" do
      table_for user.favorites do |t|
        t.column "Event" do |favorite|
          link_to favorite.event.name, admin_event_path(id: favorite.event.id)
        end
        t.column "Start Date" do |favorite|
          favorite.event.starts_at
        end
        t.column "Time Zone" do |favorite|
          favorite.event.time_zone
        end
      end
    end
  end
end
