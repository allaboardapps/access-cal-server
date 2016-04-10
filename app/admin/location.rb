ActiveAdmin.register Location do
  menu parent: "Locales", priority: 200

  actions :all

  permit_params :region_id, :name, :abbreviation, :time_zone, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "lower(name) asc"

  filter :name

  index do
    column :name
    column :abbreviation
    column "Region" do |region|
      link_to region.name, admin_region_path(region)
    end
    actions
  end

  form do |f|
    f.inputs "Location" do
      f.input :name
      f.input :abbreviation
      f.input :region
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
      row :abbreviation
      row "Region" do |location|
        link_to location.region.name, admin_region_path(location.region)
      end
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end
  end
end
