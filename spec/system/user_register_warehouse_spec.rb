require 'rails_helper'

describe 'Usuário acessa o cadastro de galpões' do
    
    it 'a partir da tela inicial' do

        #Arrange

        #Act
        visit(root_path)
        click_on('Cadastrar galpão')

        #Assert
        
        expect(page).to have_field('Nome')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Código')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Área')
        expect(page).to have_field('Descrição')
    end

    it 'vê um botão de cadastro e cadastra o galpão e visualiza uma mensagem de sucesso' do 

        #Arrange

        #Act
        visit(root_path)
        click_on('Cadastrar galpão')
        fill_in('Descrição', with: 'Galpão do aeroporto de RJ')
        fill_in('Nome', with: 'Aeroporto de RJ')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('Código', with: 'RIO')
        fill_in('Endereço', with: 'Avenida Depois de amanhã, 199')
        fill_in('CEP', with: '20894-640')
        fill_in('Área', with: '49000')
        click_on('Cadastrar galpão')

        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Galpão cadastrado com sucesso')
        expect(page).to have_content('Aeroporto de RJ')
        expect(page).to have_content("RIO")
        expect(page).to have_content("Rio de Janeiro")
        expect(page).to have_content("49000")
    end

end