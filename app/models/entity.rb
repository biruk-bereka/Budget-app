class Entity < ApplicationRecord
  belongs_to :user
  has_many :entity_groups, dependent: :destroy
  has_many :groups, through: :entity_groups
end
