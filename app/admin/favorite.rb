ActiveAdmin.register Favorite do
  menu parent: "Users", priority: 200

  actions :all

  permit_params :user_id, :event_id, :archived, :test, :dummy

  scope :active, default: true
  scope :archived
  scope :test
  scope :dummy

  config.sort_order = "created_at asc"

  filter :user
  filter :event

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
    f.inputs "Favorite" do
      f.input :user
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
      row :user
      row :event
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end
  end
end
