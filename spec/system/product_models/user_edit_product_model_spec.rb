require 'rails_helper'


describe 'Usuário acessa edição de modelo de produto' do 

    it 'com sucesso' do
        @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
        @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
        @product_model = ProductModel.create!(name: 'Fone sem fio', weight: 30, width: 3, height: 4, depth: 2, sku: 'FON19-SAMSU-XTZ14A89', supplier: @supplier)
        login_as(@user, :scope => :user)
        visit(root_path)
        within 'nav' do
        click_on('Modelos de Produtos')
        end
        click_on('Fone sem fio')
        click_on('Editar')

        expect(current_path).to eq(edit_product_model_path(@product_model.id))
        expect(page).to have_field('Nome', with: 'Fone sem fio')
        expect(page).to have_field('Código', with: 'FON19-SAMSU-XTZ14A89')
        expect(page).to have_select('Fornecedor', selected: 'Samsung')
    end

    it 'e edita com sucesso' do
        @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
        @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
        @product_model = ProductModel.create!(name: 'Fone sem fio', weight: 30, width: 3, height: 4, depth: 2, sku: 'FON19-SAMSU-XTZ14A89', supplier: @supplier)
        login_as(@user, :scope => :user)
        visit(root_path)
        within 'nav' do
        click_on('Modelos de Produtos')
        end
        click_on('Fone sem fio')
        click_on('Editar')
        fill_in('Nome', with: 'Fone Wireless 3.1')
        fill_in('Código', with: 'FON19-SAMSU-WIR14A89')
        click_on('Atualizar Modelo de Produto')

        expect(current_path).to eq(product_model_path(@product_model.id))
        expect(page).to have_content('Modelo de produto atualizado com sucesso!')
        expect(page).to have_content('Nome: Fone Wireless 3.1')
        expect(page).to have_content('Código: FON19-SAMSU-WIR14A89')
        expect(page).to have_content('Fornecedor: Samsung')
    end

    it 'e edita com campos inválidos' do
        @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
        @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
        @product_model = ProductModel.create!(name: 'Fone sem fio', weight: 30, width: 3, height: 4, depth: 2, sku: 'FON19-SAMSU-XTZ14A89', supplier: @supplier)
        login_as(@user, :scope => :user)
        visit(root_path)
        within 'nav' do
        click_on('Modelos de Produtos')
        end
        click_on('Fone sem fio')
        click_on('Editar')
        fill_in('Nome', with: 'Fone Wireless 3.1')
        fill_in('Peso', with: '0')
        fill_in('Código', with: 'FO19-SAU-WIR9')
        click_on('Atualizar Modelo de Produto')

        expect(page).to have_content('Não foi possível atualizar o modelo de produto')
        expect(page).to have_field('Nome', with: 'Fone Wireless 3.1')
        expect(page).to have_content('Código deve conter 20 caracteres')
        expect(page).to have_content('Peso deve ser maior que 0')
    end
end