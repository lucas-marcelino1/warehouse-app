require 'rails_helper'

describe 'Usuário acessa os fornecedores' do

    it 'a partir da tela inicial' do
        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        expect(current_path).to eq(suppliers_path)
    end

    it 'e visualiza todos os fornecedores' do
        @supplier = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                    address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        expect(page).to have_content('Razão social: Inox Brasil LTDA')
        expect(page).to have_content('Blumenau/Santa Catarina')
        expect(page).to have_content('E-mail: inoxbrasilcontato@inox.com.br')
    end

    it 'a partir da tela inicial e volta para a home' do
        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
            click_on('Home')
        end
        expect(current_path).to eq(root_path)
    end

    it 'e não visualiza fornecedor nenhum' do
        visit(root_path)
        within 'nav' do
            click_on('Fornecedores')
        end
        expect(page).to have_content('Não há fornecedores cadastrados!')
    end


end