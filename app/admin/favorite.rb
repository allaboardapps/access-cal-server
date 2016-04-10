ActiveAdmin.register Favorite do
  menu parent: "Users", priority: 200

  actions :all

  permit_params :user_id, :event_id, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "created_at asc"

  filter :user
  filter :event

  index do
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
