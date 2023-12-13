require 'rails_helper'

describe 'Usuário adiciona receitas à sua lista de receitas' do
  it 'a partir da home' do
    admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
    user = User.create(email: 'user@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                    ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
    list = RecipeList.create!(name: 'Lista de Sobremesas', user_id: user.id)
    login_as(user)
    visit root_path
    click_on 'Minhas Listas'
    click_on 'Adicionar Receita'
  
    expect(current_path).to eq add_recipe_recipe_list_path(list.id)
    expect(page).to have_content 'Adicionar Receita'
    expect(page).to have_content 'Receita'
  end

  it 'com sucesso' do
    admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
    user = User.create(email: 'user@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                    ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
    list = RecipeList.create!(name: 'Lista de Sobremesas', user_id: user.id)
    login_as(user)
    visit root_path
    click_on 'Minhas Listas'
    click_on 'Adicionar Receita'
    select 'Brigadeiro', from: 'Receita'
    click_on 'Adicionar'
    
    expect(current_path).to eq recipe_lists_path
    expect(page).to have_content 'Receita Adicionada com Sucesso'
    expect(page).to have_content 'Brigadeiro'
  end
end