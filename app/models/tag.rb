class Tag < ApplicationRecord
  validates :title, uniqueness: true
end
