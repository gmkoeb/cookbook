class Api::V1::RecipesController < ActionController::API
  def index
    recipes = Recipe.all
    query = params[:query]
    if query
      recipes = Recipe.where("title LIKE ? OR recipe_type_id LIKE ?", "%#{query}%", "%#{query}%")
      return render status: 200, json: recipes
    end

    return render status: 200, json: recipes
  end
end