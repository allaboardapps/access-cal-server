ActiveAdmin.register Event do
  menu parent: "Events", priority: 100

  actions :all

  permit_params(
    :location_id,
    :author_id,
    :name,
    :abbreviation,
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
    :test,
    :dummy
  )

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "lower(name) asc"

  filter :name
  filter :location
  filter :region

  index do
    column :name
    column :abbreviation
    column :calendar
    column "Author" do |event|
      link_to event.author.full_name, admin_user_path(event.author)
    end
    column :starts_at
    column :ends_at
    column :time_zone
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Event" do
      f.input :name
      f.input :abbreviation
      f.input :location
      f.input :author
      f.input :starts_at
      f.input :ends_at
      f.input :time_zone
      f.input :description
      f.input :street_address
      f.input :secondary_address
      f.input :city
      f.input :state
      f.input :country
      f.input :zip_code
      f.input :latitude
      f.input :longitude
      f.input :admin_notes
      f.input :archived
      f.input :test
      f.input :dummy
    end
    f.actions
  end

  show do |event|
    attributes_table do
      row :id
      row :name
      row :abbreviation
      row :description
      row "Location" do
        link_to event.location.name, admin_location_path(event.region)
      end
      row "Region" do
        link_to event.region.name, admin_region_path(event.region)
      end
      row "Author" do
        link_to event.author.full_name, admin_user_path(event.author)
      end
      row :starts_at
      row :ends_at
      row :time_zone
      row :street_address
      row :secondary_address
      row :city
      row :state
      row :country
      row :zip_code
      row :latitude
      row :longitude
      row :admin_notes
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Users" do
      table_for event.event_users.includes(:user) do |t|
        t.column "Name" do |entity|
          link_to entity.user.full_name, admin_user_path(id: user.id)
        end
        t.column "role" do |entity|
          entity.role
        end
      end
    end

    panel "Favorite Users" do
      table_for event.favorite_users.includes(:user) do |t|
        t.column "Name" do |entity|
          link_to entity.user.full_name, admin_user_path(id: user.id)
        end
      end
    end
  end
end
