ActiveAdmin.register Organization do
  menu parent: "Users", priority: 299

  actions :all

  permit_params :name, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "name asc"

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Organization" do
      f.input :name
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
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Users" do
      table_for organization.organization_users.includes(:user) do |t|
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
