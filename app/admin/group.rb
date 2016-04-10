ActiveAdmin.register Group do
  menu parent: "Users", priority: 300

  actions :all

  permit_params :name, :archived, :test, :dummy

  scope :active, default: true
  scope :archived
  scope :test
  scope :dummy

  config.sort_order = "name asc"

  filter :name
  filter :organization_name_contains, as: :string
  filter :organization, collection: Organization.order(name: :asc)

  index do
    selectable_column
    id_column
    column :user
    column :event
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Group" do
      f.input :user
      f.input :organization
      f.input :event
      f.input :archived
      f.input :test
      f.input :dummy
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :organization
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Users" do
      table_for group.group_users.includes(:user) do |t|
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
  end
end