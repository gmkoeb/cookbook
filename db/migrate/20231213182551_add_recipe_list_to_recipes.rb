class AddRecipeListToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :recipe_list, null: true, foreign_key: true
  end
end
