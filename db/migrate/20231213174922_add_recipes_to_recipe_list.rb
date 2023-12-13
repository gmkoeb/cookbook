class AddRecipesToRecipeList < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipe_lists, :recipe, null: false, foreign_key: true
  end
end
