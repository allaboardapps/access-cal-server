ActiveAdmin.register User do
  menu parent: "Users", priority: 10

  actions :all

  permit_params(
    :email,
    :first_name,
    :last_name,
    :admin_notes,
    :archived,
    :roles,
    :zip_code,
    :time_zone,
    :test,
    :password
  )

  scope :active, default: true
  scope :customers
  scope :clients
  scope :admins
  scope :archived
  scope :test

  config.sort_order = "lower(last_name) asc, lower(first_name) asc"

  filter :first_name
  filter :last_name
  filter :email

  index do |user|
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email do
      mail_to user.email, user.email
    end
    column :roles do
      user.roles_presented
    end
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :admin_notes
      f.input :zip_code
      f.input :archived
      f.input :test
      # f.input :password, hint: "8 alphanumeric characters required"
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :roles do
        user.roles_presented
      end
      row :email do
        mail_to user.email, user.email
      end
      row :admin_notes
      row :archived
      row :test
      row :created_at
      row :updated_at
    end

    panel "Favorites" do
      # if user.is?(UserRoles::TUTOR)
      #   table_for user.favorites.includes(:events) do |t|
      #     t.column "ID" do |tutor_assignment|
      #       tutor_assignment.id
      #     end
      #     t.column "Classroom ID" do |tutor_assignment|
      #       link_to tutor_assignment.classroom.id, admin_classroom_path(id: tutor_assignment.classroom.id)
      #     end
      #   end
      # end
    end
  end
end
