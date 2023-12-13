require 'rails_helper'

describe 'Usuário adiciona receita à lista de receitas' do
  it 'a partir da home' do
    admin = create(:user, email: 'admin@email.com',
                          password: '123456', role: :admin)
    user = User.create(email: 'user@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                   ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
                  
    login_as(user)
    visit root_path
    click_on 'Minhas Listas'
    click_on 'Criar Lista de Receitas'

    expect(current_path).to eq new_recipe_list_path
    expect(page).to have_field 'Nome da Lista'
    expect(page).to have_button 'Criar Lista'
  end
  
  it 'com sucesso' do
    admin = create(:user, email: 'admin@email.com',
                          password: '123456', role: :admin)
    user = User.create(email: 'user@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    Recipe.create!(title: 'Brigadeiro', cook_time: 120, recipe_type_id: recipe_type.id, 
                   ingredients: 'Leite Condensado, Nescau', instructions: 'Ferver no fogão até atingir o ponto certo', user_id: admin.id )
    login_as(user)
    visit new_recipe_list_path
    fill_in 'Nome da Lista', with: 'Lista de Sobremesas'
    click_on 'Criar Lista'

    expect(current_path).to eq recipe_lists_path
    expect(page).to have_content 'Lista de Receitas criada com sucesso'
    expect(page).to have_content 'Listas de Receitas'
    expect(page).to have_content 'Lista de Sobremesas'
  end
end