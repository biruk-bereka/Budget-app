class Entity < ApplicationRecord
  belongs_to :user
  has_many :entity_groups, dependent: :destroy
  has_many :groups, through: :entity_groups

  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true, comparison: { greater_than: 0 }
end
