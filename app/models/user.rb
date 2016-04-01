class User < ActiveRecord::Base
  validates :email, presence: true
  validates :time_zone, presence: true

  # Include default devise modules. Others available are:
  # :omniauthable, :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable,
         :trackable, :validatable, :async, :confirmable, :lockable

  scope :active, -> { where(archived: false, test: false) }
  scope :admins, -> { where("'#{UserRoles::ADMIN}' = ANY (roles)").order(last_name: :asc) }
  scope :archived, -> { where(archived: true) }
  scope :authors, -> { where("'#{UserRoles::AUTHOR}' = ANY (roles)").order(last_name: :asc) }
  scope :autocomplete, -> (user_query) { active.where("first_name ilike ? or last_name ilike ?", "#{user_query}%", "#{user_query}%").order(last_name: :asc, first_name: :asc) }
  scope :customers, -> { where("'#{UserRoles::CUSTOMER}' = ANY (roles)").order(last_name: :asc) }
  scope :test, -> { where(test: true) }
  scope :with_one_of_roles, ->(*roles) { where.overlap(roles: roles) }

  belongs_to :location
  has_many :activities, as: :loggable
  has_many :authored_events, class_name: "Event", foreign_key: :author_id
  has_many :calendar_users
  has_many :calendars, through: :calendar_users
  has_many :favorited_events, class_name: "Favorite"
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_one :region, through: :location

  after_create :set_default_role

  def generate_token!
    self.token = SecureRandom.hex
    save!
  end

  def full_name
    "#{first_name} #{last_name}".gsub(/\b('?[a-z])/) { $1.capitalize }.strip
  end

  def first_name_abbreviated(last_name_length = 7)
    first_name_abbrev = first_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, 1)
    last_name_abbrev = last_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, last_name_length)
    "#{first_name_abbrev}. #{last_name_abbrev}"
  end

  def last_name_abbreviated(first_name_length = 7)
    first_name_abbrev = first_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, first_name_length)
    last_name_abbrev = last_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, 1)
    "#{first_name_abbrev} #{last_name_abbrev}."
  end

  def active_admin_access?
    roles.any? { |role| Roles.system_roles.include?(role) }
  end

  def active_for_authentication?
    super && !self.archived?
  end

  def user_role?
    roles.any? { |role| Roles.user_roles.include?(role) }
  end

  def is?(role)
    roles.include? role
  end

  def is_not?(role)
    !roles.include? role
  end

  def roles_contain_one_of?(allowed_roles)
    roles.any? do |role|
      allowed_roles.include? role
    end
  end

  def set_default_role
    update_attribute :roles, [UserRoles::CUSTOMER] if roles.empty?
  end

  def admin?
    is? UserRoles::ADMIN
  end

  def customer?
    is? UserRoles::CUSTOMER
  end

  def client?
    is? UserRoles::CLIENT
  end

  def status_is?(role)
    statuses.include? role
  end

  def status_is_not?(role)
    !statuses.include? role
  end

  def basic?
    status_is?(Statuses::BASIC) || status_is?(Statuses::PRO) || status_is?(Statuses::PREMIUM)
  end

  def pro?
    status_is?(Statuses::PRO) || status_is?(Statuses::PREMIUM)
  end

  def premium?
    status_is?(Statuses::PREMIUM)
  end

  def active_admin_access?
    roles.any? { |role| UserRoles.active_admin_roles.include?(role) }
  end

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end

  def roles_presented
    roles.join(", ")
  end
end
