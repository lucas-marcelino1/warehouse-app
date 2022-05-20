require 'rails_helper'

describe 'Usuário visualiza o modelo de produto' do
    
    it 'sem sucesso porque não está logado' do

        visit(root_path)
        click_on('Modelos de Produtos')

        expect(current_path).to eq(new_user_session_path)

    end

    it 'a partir da home' do
        @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
        @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

        ProductModel.create!(name: 'TV 32in', weight: 2000, width: 70, height: 45, depth: 10, sku:'TV32I-SAMSU-XPTZXO90', supplier: @supplier)
        
        login_as(@user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32in')

        expect(current_path).to eq(product_model_path(ProductModel.last.id))
        expect(page).to have_content('Nome: TV 32in')
        expect(page).to have_content('Código: TV32I-SAMSU-XPTZXO90')
        expect(page).to have_content('Fornecedor: Samsung Brasil LTDA')
        expect(page).to have_content('Peso: 2000g')
        expect(page).to have_content('Dimensões: 70cm x 45cm x 10cm')

    end

    it 'a partir da home e volta para a página principal' do
        @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
        @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

        ProductModel.create!(name: 'TV 32in', weight: 2000, width: 70, height: 45, depth: 10, sku:'TV32I-SAMSU-XPTZXO90', supplier: @supplier)
        
        login_as(@user, :scope => :user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32in')
        click_on('Galpões & Estoque')

        expect(current_path).to eq(root_path)
       
    end
end