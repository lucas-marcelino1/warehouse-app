require 'rails_helper'

describe 'Usuário se registra' do
    it 'com sucesso' do
        visit(root_path)
        click_on('Entrar')
        click_on('Cadastrar nova conta')
        fill_in('Nome', with: 'Júlia')
        fill_in('E-mail', with: 'juliarezende@gmail.com')
        fill_in('Senha', with: '123456')
        fill_in('Confirme sua senha', with: '123456')
        click_on('Criar conta')

        expect(page).to have_content('Boas vindas! Você realizou seu registro com sucesso.')
        expect(page).to have_content('juliarezende@gmail.com')
        expect(page).to have_button('Sair')
        expect(User.last.name).to eq('Júlia')
    end

    it 'com campos inválidos' do
        visit(root_path)
        click_on('Entrar')
        click_on('Cadastrar nova conta')
        fill_in('Nome', with: '')
        fill_in('E-mail', with: 'juliarezende@gmail.com')
        fill_in('Senha', with: '123456')
        fill_in('Confirme sua senha', with: '123456')
        click_on('Criar conta')

        expect(page).to have_content('Não foi possível salvar usuário')
    end
end