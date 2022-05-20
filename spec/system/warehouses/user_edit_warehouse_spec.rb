require 'rails_helper'

describe 'Usuário edita um galpão' do

    it 'a partir da página de detalhes' do

        #Arrange
        w = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
        
        #Act
        visit(root_path)
        click_on('Rio')
        click_on('Editar')

        #Assert
        expect(current_path).to eq(edit_warehouse_path(w.id))
        expect(page).to have_field('Nome', with: 'Rio')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('Código', with: 'SDU')
        expect(page).to have_field('Endereço', with: 'Av do Porto do Rio')
        expect(page).to have_field('CEP', with: '20000-000')
        expect(page).to have_field('Área', with: '50000')
        expect(page).to have_field('Descrição', with: 'Galpão do Rio')

    end

    it 'preenche o formulário e edita um galpão' do 
    
        #Arrange
        w = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    
        #Act
        visit(root_path)
        click_on('Rio')
        click_on('Editar')
        fill_in('Nome', with: 'São P.')
        fill_in('Cidade', with: 'São Paulo')
        fill_in('Código', with: 'ITB')
        fill_in('Endereço', with: 'Av do Porto de SP')
        fill_in('CEP', with: '30000-000')
        fill_in('Área', with: '30000')
        fill_in('Descrição', with: 'Galpão de São Paulo')
        click_on('Atualizar Galpão')

        #Assert
        expect(current_path).to eq(warehouse_path(w.id))
        expect(page).to have_content('Galpão atualizado com sucesso')
        expect(page).to have_content('Galpão ITB')
        expect(page).to have_content('São P.')
        expect(page).to have_content('Cidade: São Paulo')
        expect(page).to have_content('Endereço: Av do Porto de SP - CEP: 30000-000')
        expect(page).to have_content('Galpão de São Paulo')
        expect(page).to have_content('Área: 30000')

    end

    it 'e não consegue atualizar o galpão' do

         #Arrange
         w = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    
         #Act
         visit(root_path)
         click_on('Rio')
         click_on('Editar')
         fill_in('Nome', with: '')
         fill_in('Cidade', with: '')
         fill_in('Código', with: '')
         fill_in('Endereço', with: '')
         click_on('Atualizar Galpão')

         #Assert
         expect(page).to have_content('Não foi possível atualizar o galpão')
         
    end
end