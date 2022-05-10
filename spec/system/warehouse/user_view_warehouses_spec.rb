require 'rails_helper'


describe 'Usuário visualiza um galpão' do

    it 'clica no galpão e vê os detalhes deste galpão' do
        #Arrange
        Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
                        address: 'Avenida do aeroporto, 498', cep: '84875-687',
                        description: 'Armazém destinado à mercadorias internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto de SP')


        #Assert
        expect(page).to have_content('Galpão GRU')
        expect(page).to have_content('Aeroporto de SP')
        expect(page).to have_content('Cidade: São Paulo')
        expect(page).to have_content('Endereço: Avenida do aeroporto, 498 - CEP: 84875-687')
        expect(page).to have_content('Armazém destinado à mercadorias internacionais')
        expect(page).to have_content('Área: 90000')
    end

    it 'acessa o galpão e volta para o menu principal' do 
        #Arrange
        Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
            address: 'Avenida do aeroporto, 498', cep: '84875-687',
            description: 'Armazém destinado à mercadorias internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto de SP')
        click_on('Home')

        #Assert
        expect(current_path).to eq(root_path)

    end


end