ActiveAdmin.register Event do
  menu parent: "Events", priority: 100

  actions :all

  permit_params(
    :location_id,
    :author_id,
    :name,
    :abbreviation,
    :primary_category,
    :categories,
    :description,
    :street_address,
    :secondary_address,
    :city,
    :state,
    :country,
    :zip_code,
    :time_zone,
    :latitude,
    :longitude,
    :starts_at,
    :ends_at,
    :admin_notes,
    :archived,
    :test
  )

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
    column :primary_category
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
      f.input :primary_category
      f.input :categories
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
      f.input :time_zone
      f.input :latitude
      f.input :longitude
      f.input :admin_notes
      f.input :archived
      f.input :test
    end
    f.actions
  end

  show do |event|
    attributes_table do
      row :id
      row :name
      row :abbreviation
      row :primary_category
      row :categories
      row "Location" do
        link_to event.location.name, admin_location_path(event.region)
      end
      row "Region" do
        link_to event.region.name, admin_region_path(event.region)
      end
      row "User" do
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
      row :time_zone
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
