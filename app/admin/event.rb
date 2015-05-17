ActiveAdmin.register Event do
  menu parent: "Events", priority: 100

  actions :all

  permit_params :location_id,
    :client_id,
    :location_id,
    :name,
    :abbreviation,
    :description,
    :street_address,
    :secondary_address,
    :city,
    :state,
    :country,
    :zip_code,
    :timezone,
    :latitude,
    :longitude,
    :starts_at,
    :ends_at,
    :admin_notes,
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
    column "Region" do |event|
      link_to event.region.name, admin_region_path(event.region)
    end
    column "Client" do |event|
      link_to event.client.full_name, admin_user_path(event.client)
    end
    column :starts_at
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Event" do
      f.input :name
      f.input :abbreviation
      f.input :location
      f.input :client
      f.input :starts_at
      f.input :ends_at
      f.input :description
      f.input :street_address
      f.input :secondary_address
      f.input :city
      f.input :state
      f.input :country
      f.input :zip_code
      f.input :timezone
      f.input :latitude
      f.input :longitude
      f.input :admin_notes
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
      row "User" do |event|
        link_to event.client.full_name, admin_user_path(event.client)
      end
      row :starts_at
      row :ends_at
      row :description
      row :street_address
      row :secondary_address
      row :city
      row :state
      row :country
      row :zip_code
      row :timezone
      row :latitude
      row :longitude
      row :admin_notes
      row :archived
      row :test
      row :created_at
      row :updated_at
    end
  end
end
