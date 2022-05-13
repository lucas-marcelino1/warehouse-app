require 'rails_helper'


describe 'Usuário acessa tela de cadastro de produtos' do
    
    it 'a partir da tela inicial' do

        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar novo modelo de produto')

        expect(current_path).to eq(new_product_model_path)

    end

    it 'e cadastra um modelo de produto' do

        Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
        Supplier.create!(corporation_name: 'Inox do Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1220-10',
                address: 'Rua Progresso, 8954', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@gmail.com.br')
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar novo modelo de produto')
        fill_in('Nome', with: 'Tv de 42 polegadas')
        fill_in('Peso', with: '1650')
        fill_in('Largura', with: '70')
        fill_in('Altura', with: '30')
        fill_in('Profundidade', with: '8')
        fill_in('Código', with: 'STUO38-SAMSU-PLASM42')
        select('Samsung', from: 'Fornecedor')
        click_on('Criar Modelo de Produto')

        expect(current_path).to eq(product_models_path)
        expect(page).to have_content('Modelo de produto cadastrado com sucesso!')
        expect(page).to have_content('Tv de 42 polegadas')
        expect(page).to have_content('STUO38-SAMSU-PLASM42')
        expect(page).to have_content('Samsung')

    end

    it 'e tenta cadastrar modelo de produto com campos inválidos' do

        Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar novo modelo de produto')
        fill_in('Nome', with: 'Tv de 42 polegadas')
        fill_in('Peso', with: '1650')
        fill_in('Largura', with: '0')
        fill_in('Altura', with: '0')
        fill_in('Profundidade', with: '8')
        fill_in('Código', with: 'STUO38-SASU-PLASM42')
        select('Samsung', from: 'Fornecedor')
        click_on('Criar Modelo de Produto')

        expect(page).to have_content('Não foi possível cadastrar o modelo de produto!')
        expect(page).to have_content('Código deve conter 20 caracteres')
        expect(page).to have_content('Largura deve ser maior que 0')
        expect(page).to have_content('Altura deve ser maior que 0')
        expect(page).to have_field('Nome', with: 'Tv de 42 polegadas')
        expect(page).to have_field('Peso', with: '1650')
        expect(page).to have_select('Fornecedor', selected: 'Samsung')
        

    end


end