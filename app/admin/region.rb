ActiveAdmin.register Region do
  menu parent: "Locales", priority: 100

  actions :all

  permit_params :name, :abbreviation, :time_zone, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "lower(name) asc"

  filter :name

  index do
    column :name
    column :abbreviation
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :abbreviation
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
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end

    panel "Locations" do
      table_for region.locations do |t|
        t.column "Name" do |location|
          link_to location.name, admin_location_path(id: location.id)
        end
      end
    end
  end
end
