require 'rails_helper'

describe 'Usuário acessa a tela inicial' do 

    it 'e visualiza o nome da aplicação' do 
        #Arrange

        #Act
        visit(root_path)

        #Assert
        expect(page).to have_content("Galpões & Estoque")
        expect(page).to have_link('Galpões & Estoque', href: root_path)
    end

    it 'e visualiza os galpões cadastrados' do 
        #Arrange
        Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
        Warehouse.create!(name: 'Maceio', cod: 'MCZ', city: 'Maceió', area: 60_000, cep: '45000-200', address: 'Av Maceió', description: 'Galpão de Maceió')
        
        #Act
        visit(root_path)

        #Assert
        expect(page).not_to have_content("Não há galpões cadastrados")
        expect(page).to have_content("Rio")
        expect(page).to have_content("SDU")
        expect(page).to have_content("Rio de Janeiro")
        expect(page).to have_content("50000 m²")
        
        expect(page).to have_content("Maceio")
        expect(page).to have_content("MCZ")
        expect(page).to have_content("Maceió")
        expect(page).to have_content("60000 m²")
    end

    it 'e não existem galpões cadastrados' do 

        #Arrange

        #Act
        visit(root_path)
        
        #Assert
        expect(page).to have_content("Não há galpões cadastrados")

    end

    it 'e busca um galpão pelo nome, código e cidade na tela inicial' do
        Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')

        visit(root_path)
        fill_in('Nome', with: 'Rio')
        fill_in('Código', with: 'SDU')
        fill_in('Cidade', with: 'Rio de Janeiro')
        click_on('Filtrar galpão')

        expect(page).to have_content('Rio')
        expect(page).to have_content('SDU')
        expect(page).to have_content("Rio de Janeiro")
        expect(page).to have_content("50000 m²")
    end


end