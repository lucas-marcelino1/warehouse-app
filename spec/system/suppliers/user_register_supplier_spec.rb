require 'rails_helper'

describe 'Usuário acessa o registro de fornecedor' do

    it 'a partir da home' do
        
        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Cadastrar fornecedor')

        expect(current_path).to eq(new_supplier_path)
    end

    it 'e registra um fornecedor' do

        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Cadastrar fornecedor')
        fill_in('Razão Social', with: 'Livrarias Catarinense Excepcionais LTDA')
        fill_in('Nome Fantasia', with: 'Livrarias Catarinense')
        fill_in('CNPJ', with: '12.345.678/1000-10')
        fill_in('Cidade', with: 'Massaranduba')
        fill_in('Estado', with: 'Santa Catarina')
        fill_in('Endereço', with: 'Av. Rio Branco, 457')
        fill_in('E-mail', with: 'livroscatarinense@gmail.com')
        click_on('Criar Fornecedor')

        expect(current_path).to eq(suppliers_path)
        expect(page).to have_content('Fornecedor cadastrado com sucesso.')
        expect(page).to have_content('Razão social: Livrarias Catarinense Excepcionais LTDA')
        expect(page).to have_content('Massaranduba/Santa Catarina')
        expect(page).to have_content('E-mail: livroscatarinense@gmail.com')

    end

    it 'e tenta registrar um fornecedor com campos inválidos' do

        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        click_on('Cadastrar fornecedor')
        fill_in('Razão Social', with: '')
        fill_in('Nome Fantasia', with: 'Livrarias Catarinense')
        fill_in('CNPJ', with: '12.345.78/1000-1')
        fill_in('Cidade', with: 'Massaranduba')
        fill_in('Estado', with: 'Santa Catarina')
        fill_in('Endereço', with: 'Av. Rio Branco, 457')
        fill_in('E-mail', with: 'livroscatarinense@gmail.com')
        click_on('Criar Fornecedor')

        expect(current_path).to eq(suppliers_path)
        expect(page).to have_content('Não foi possível cadastrar o fornecedor')
        expect(page).to have_content('Razão Social não pode ficar em branco.')
        expect(page).to have_content('CNPJ deve ter o formato XY.XYZ.XYZ/XYZA-XYZ')


    end

end