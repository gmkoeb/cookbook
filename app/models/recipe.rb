class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  belongs_to :recipe_lists, optional: true
  validates :title, :cook_time, :ingredients, :instructions, presence: true
end
