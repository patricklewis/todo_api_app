class Task < ApplicationRecord
  validates :title, presence: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
