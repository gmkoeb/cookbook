class RecipeListsController < ApplicationController
  def index
    @recipe_lists = current_user.recipe_lists
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    recipe_list_params = params.require(:recipe_list).permit(:name)
    @recipe_list = RecipeList.new(recipe_list_params)
    @recipe_list.user = current_user
    if @recipe_list.save
      flash[:notice] = 'Lista de Receitas criada com sucesso'
      return redirect_to recipe_lists_path
    else
      flash.now[:alert] = 'Não foi possível criar Lista de Receitas'
      render 'new'
    end
  end

  def add_recipe
    @recipe_list = RecipeList.find(params[:id])
    recipe = Recipe.find_by()
    if recipe.save 
      flash[:notice] = 'Receita adicionada à lista com sucesso'
      return redirect_to recipe_lists_path
    end
  end
end