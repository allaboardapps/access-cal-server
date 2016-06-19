ActiveAdmin.register Occurrence do
  menu parent: "Events", priority: 100

  actions :all

  permit_params(
    :event_id,
    :starts_at,
    :ends_at,
    :time_zone,
    :archived,
    :test,
    :dummy
  )

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "starts_at_asc"

  controller do
    def scoped_collection
      super.includes(:author, :calendar)
    end
  end

  index do
    column "Event" do |occurrence|
      link_to occurrence.event.name, admin_event_path(occurrence.event)
    end
    column :starts_at
    column :ends_at
    column :time_zone
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Occurrence" do
      f.input :event
      f.input :starts_at
      f.input :ends_at
      f.input :time_zone
      f.input :archived
      f.input :test
      f.input :dummy
    end
    f.actions
  end

  show do |occurrence|
    attributes_table do
      row :id
      row "Event" do
        link_to occurrence.event.name, admin_event_path(occurrence.event)
      end
      row :starts_at
      row :ends_at
      row :time_zone
      row :archived
      row :test
      row :dummy
      row :created_at
      row :updated_at
    end
  end
end
