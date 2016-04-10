ActiveAdmin.register Tag do
  menu parent: "Events", priority: 200

  actions :all

  permit_params :name, :tag_type, :tag_category, :archived, :test, :dummy

  scope :actives, default: true
  scope :archives
  scope :tests
  scope :dummies

  config.sort_order = "lower(name) asc"

  filter :name
  filter :tag_type, as: :select, collection: TagTypes.all
  filter :tag_category, as: :select, collection: TagCategories.all

  index do
    column :name
    column :tag_type
    column :tag_category
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Tag" do
      f.input :name
      f.input :tag_type
      f.input :tag_category
      f.input :archived
      f.input :test
      f.input :dummy
    end
    f.actions
  end
end
