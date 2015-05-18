ActiveAdmin.register Location do
  menu parent: "Locales", priority: 200

  actions :all

  permit_params :region_id, :name, :abbreviation, :time_zone, :archived, :test, :time_zone

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
    column "Region" do |region|
      link_to region.name, admin_region_path(region)
    end
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Location" do
      f.input :name
      f.input :abbreviation
      f.input :region
      f.input :archived
      f.input :test
    end
    f.actions
  end

  show do |location|
    attributes_table do
      row :id
      row :name
      row :abbreviation
      row "Region" do |region|
        link_to region.name, admin_region_path(region)
      end
      row :archived
      row :test
      row :created_at
      row :updated_at
    end
  end
end
