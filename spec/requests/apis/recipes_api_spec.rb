require 'rails_helper'

describe 'Recipes API' do
  context 'GET /api/v1/recipes' do
    it 'retorna todas as receitas cadastradas' do   
      admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
      user = User.create(email: 'user@email.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      Recipe.create!(title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                     ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
      
      get "/api/v1/recipes"
  
      expect(response.status).to eq 200
    end
  end
end