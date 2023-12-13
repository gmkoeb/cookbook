require 'rails_helper'

describe 'Recipes API' do
  context 'GET /api/v1/recipes' do
    it 'retorna todas as receitas cadastradas' do   
      admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
      user = User.create(email: 'user@email.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      Recipe.create!( title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                      ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
      
      get "/api/v1/recipes"
  
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' 
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response[0]["title"]).to include('Brigadeiro')   
      expect(json_response[0]["cook_time"]).to eq 120   
      expect(json_response[0]["recipe_type_id"]).to eq 1
    end

   
  end

  context 'GET /api/v1/recipes?query=title' do
    it 'filtra receitas dependendo da query' do
      admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
      user = User.create(email: 'user@email.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      Recipe.create!( title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                      ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
      Recipe.create!( title: 'Beijinho', cook_time: 120, recipe_type_id: recipe_type.id, 
                      ingredients: 'Leite Condensado, Coco Ralado', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )

      get "/api/v1/recipes?query=bri"
  
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' 
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response[0]["title"]).to include('Brigadeiro')   
      expect(json_response[0]["cook_time"]).to eq 120   
      expect(json_response[0]["recipe_type_id"]).to eq 1
    end
  end

  context 'GET /api/v1/recipes?query=recipe_type_id' do
    it 'filtra receitas dependendo da query' do
      admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
      user = User.create(email: 'user@email.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      Recipe.create!( title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                      ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
      Recipe.create!( title: 'Beijinho', cook_time: 120, recipe_type_id: recipe_type.id, 
                      ingredients: 'Leite Condensado, Coco Ralado', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )

      get "/api/v1/recipes?query=1"
  
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' 
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["title"]).to include('Brigadeiro')   
      expect(json_response[0]["cook_time"]).to eq 120   
      expect(json_response[0]["recipe_type_id"]).to eq 1
    end
  end
end