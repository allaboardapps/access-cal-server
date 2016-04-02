class Tag < ActiveRecord::Base
  validates :taggable, presence: true

  belongs_to :taggable, polymorphic: true
end
