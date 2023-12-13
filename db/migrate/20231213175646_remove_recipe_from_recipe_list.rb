class RemoveRecipeFromRecipeList < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipe_lists, :recipe_id
  end
end
