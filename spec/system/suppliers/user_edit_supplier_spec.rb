require 'rails_helper'

describe 'Usuário acessa a edição de fornecedor' do 

    it 'a partir da home' do

        @supplier = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')


        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Inox Brasil LTDA')
        click_on('Editar Fornecedor')

        expect(current_path).to eq(edit_supplier_path(@supplier.id))
        expect(page).to have_content('Edição de Inox Brasil LTDA')
        expect(page).to have_field('Razão Social', with: 'Inox Brasil LTDA')
        expect(page).to have_field('CNPJ', with: '12.345.678/1000-10')
        expect(page).to have_field('E-mail', with: 'inoxbrasilcontato@inox.com.br')


    end

    it 'e realiza edição com sucesso' do

        @supplier = Supplier.create!(corporation_name: 'Inoxi', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')


        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Inoxi')
        click_on('Editar Fornecedor')
        fill_in('Razão Social', with: 'Inox Brasil LTDA')
        fill_in('Cidade', with: 'Petrolina')
        fill_in('CNPJ', with: '12.534.678/1000-10')
        click_on('Atualizar Fornecedor')

        expect(current_path).to eq(supplier_path(@supplier.id))
        expect(page).to have_content('Razão Social: Inox Brasil LTDA')
        expect(page).to have_content('CNPJ: 12.534.678/1000-10')
        expect(page).to have_content('Cidade/UF: Petrolina/Santa Catarina')

    end

    it 'e preenche com campos inválidos' do

        @supplier = Supplier.create!(corporation_name: 'Inoxi', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')


        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Inoxi')
        click_on('Editar Fornecedor')
        fill_in('Razão Social', with: 'Inox Brasil LTDA')
        fill_in('Cidade', with: '')
        fill_in('CNPJ', with: '12.54.678/1000-10')
        click_on('Atualizar Fornecedor')

        expect(current_path).to eq(supplier_path(@supplier.id))
        expect(page).to have_content('Não foi possível atualizar o fornecedor')
        expect(page).to have_content('CNPJ deve ter o formato XY.XYZ.XYZ/XYZA-XYZ')
        expect(page).to have_content('Cidade não pode ficar em branco')

    end

end