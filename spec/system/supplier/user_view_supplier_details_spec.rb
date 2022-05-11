require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
    it 'a partir da home' do
        @supplier = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                    address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
        visit(root_path)
        within ('nav') do
           click_on('Fornecedores') 
        end
        click_on('Inox Brasil LTDA')
        expect(current_path).to eq(supplier_path(@supplier.id))
        expect(page).to have_content('Razão Social: Inox Brasil LTDA')
        expect(page).to have_content('Nome Fantasia: Inox')
        expect(page).to have_content('CNPJ: 12.345.678/1000-10')
        expect(page).to have_content('Cidade/UF: Blumenau/Santa Catarina')
        expect(page).to have_content('Endereço: Rua Progresso, 2548')
        expect(page).to have_content('E-mail: inoxbrasilcontato@inox.com.br')


    end

    it 'a partir da home e volta à tela inicial' do
        @supplier = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                    address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
        visit(root_path)
        within ('nav') do
           click_on('Fornecedores') 
        end
        click_on('Inox Brasil LTDA')
        click_on('Home')
        expect(current_path).to eq(root_path)

    end

end