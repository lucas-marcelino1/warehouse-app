require 'rails_helper'

describe 'Usuário deleta um galpão' do

    it 'com sucesso' do

        #Arrange
        Warehouse.create!(name: 'Maceio', cod: 'MCZ', city: 'Maceió', area: 60_000, cep: 
                         '45000-200', address: 'Av Maceió', description: 'Galpão de Maceió')

        #Act
        visit(root_path)
        click_on('Maceio')
        click_on('Remover galpão')

        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Galpão removido com sucesso')
        expect(page).not_to have_content('Maceio')
        expect(page).not_to have_content('MCZ')
        expect(page).not_to have_content('Maceió')

    end

    it 'e não deleta outros galpões' do
        #Arrange
        Warehouse.create!(name: 'Maceio', cod: 'MCZ', city: 'Maceió', area: 60_000, cep: 
                            '45000-200', address: 'Av Maceió', description: 'Galpão de Maceió')
        Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep:
                         '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')

        #Act
        visit(root_path)
        click_on('Maceio')
        click_on('Remover galpão')

        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Galpão removido com sucesso')
        expect(page).not_to have_content('Maceio')
        expect(page).not_to have_content('MCZ')
        expect(page).not_to have_content('Maceió')
        expect(page).to have_content('Rio')
        expect(page).to have_content('SDU')
        expect(page).to have_content('Rio de Janeiro')
    end
end