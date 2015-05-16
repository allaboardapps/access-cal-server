ActiveAdmin.register Region do
  menu parent: "Locales", priority: 100

  actions :all

  permit_params :name, :archived, :test

  scope :active, default: true
  scope :archived
  scope :test

  config.sort_order = "lower(name) asc"

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :abbreviation
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :abbreviation
      f.input :archived
      f.input :test
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :id
      row :name
      row :abbreviation
      row :archived
      row :test
      row :created_at
      row :updated_at
    end

    panel "Locations" do
      table_for region.locations do |t|
        t.column "ID" do |location|
          location.id
        end
        t.column "Name" do |location|
          link_to location.name, admin_location_path(id: location.id)
        end
      end
    end
  end
end
