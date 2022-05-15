require 'rails_helper'


describe 'Usuário realiza login' do

    it 'com sucesso' do
        User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')

        visit(root_path)
        click_on('Entrar')
        within 'form' do
            fill_in('E-mail', with: 'lucas.marcelino@email.com')
            fill_in('Senha', with: '123456')
            click_on('Entrar')
        end

        within 'nav' do
            expect(page).not_to have_link('Entrar')
            expect(page).to have_button('Sair')
            expect(page).to have_content('lucas.marcelino@email.com')
        end
        expect(page).to have_content('Login efetuado com sucesso')
    end

    it 'e faz o logout' do
        User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')

        visit(root_path)
        click_on('Entrar')
        within 'form' do
            fill_in('E-mail', with: 'lucas.marcelino@email.com')
            fill_in('Senha', with: '123456')
            click_on('Entrar')
        end
        click_on('Sair')

        expect(page).to have_content('Logout efetuado com sucesso')
        expect(page).not_to have_content('Sair')
        expect(page).not_to have_content('lucas.marcelino@email.com')
    end

end