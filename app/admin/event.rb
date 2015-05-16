ActiveAdmin.register Event do
  menu parent: "Events", priority: 100

  actions :all

  permit_params :name,
    :abbreviation,
    :location_id,
    :archived,
    :test

  scope :active, default: true
  scope :archived
  scope :test

  config.sort_order = "lower(name) asc"

  filter :name
  filter :location
  filter :region

  index do
    selectable_column
    id_column
    column :name
    column :abbreviation
    column "Location" do |event|
      link_to event.location.name, admin_location_path(event.location)
    end
    column "Region" do |region|
      link_to event.region.name, admin_region_path(event.region)
    end
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Event" do
      f.input :name
      f.input :abbreviation
      f.input :location
      f.input :admin_note
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
      row "Location" do |event|
        link_to event.location.name, admin_location_path(region)
      end
      row "Region" do |region|
        link_to event.region.name, admin_region_path(event.region)
      end
      row :admin_note
      row :archived
      row :test
      row :created_at
      row :updated_at
    end
  end
end
