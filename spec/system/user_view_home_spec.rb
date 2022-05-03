require 'rails_helper'

describe 'Usuário acessa a tela inicial' do 

    it 'e visualiza o nome da aplicação' do 
        #Arrange

        #Act
        visit(root_path)

        #Assert
        expect(page).to have_content("Galpões & Estoque")
    end



end