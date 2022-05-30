require 'rails_helper'

describe 'Usuário registra pedido' do

  it 'com sucesso' do
    @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.689.678/1000-10',
                  address: 'Rua João Pessoa, 337', city: 'Aracuari', state: 'Pará', email: 'inoxbrasilcontato@inox.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
                    address: 'Avenida do aeroporto, 498', cep: '84875-687',
                    description: 'Armazém destinado à mercadorias internacionais')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC15864')

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Registrar pedido')
    select 'Samsung Brasil LTDA - Samsung | 12.345.678/1000-10', from: "Fornecedor"
    select 'Rio | SDU', from: 'Galpão'
    fill_in('Data prevista de entrega', with: 1.day.from_now)
    click_on('Criar Pedido')

    expect(page).to have_content("Pedido - ABC15864")
    expect(page).to have_content("Pedido realizado com sucesso!")
    expect(page).to have_content('Galpão destino: Rio | SDU')
    expect(page).to have_content('Fornecedor: Samsung Brasil LTDA - Samsung | 12.345.678/1000-10.')
    expect(page).to have_content('Responsável: User <user@gmail.com>')
    expect(page).to have_content("Data prevista de entrega: #{I18n.l(1.day.from_now.to_date, format: :long)}")
    expect(page).to have_content("Situação do pedido: Pendente")
    expect(page).not_to have_content('Galpão destino: "Aeroporto de SP"')
    expect(page).not_to have_content('Fornecedor: Inox Brasil LTDA.')
  end

  it 'sem estar autenticado' do

    visit root_path
    click_on('Registrar pedido')

    expect(current_path).to eq(new_user_session_path)
  end

  it 'com data inválida e falha' do
    @user = User.create!(name: 'User', email: 'user@gmail.com', password: '123456')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.689.678/1000-10',
                  address: 'Rua João Pessoa, 337', city: 'Aracuari', state: 'Pará', email: 'inoxbrasilcontato@inox.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
                    address: 'Avenida do aeroporto, 498', cep: '84875-687',
                    description: 'Armazém destinado à mercadorias internacionais')

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Registrar pedido')
    select 'Samsung Brasil LTDA - Samsung | 12.345.678/1000-10', from: "Fornecedor"
    select 'Rio | SDU', from: 'Galpão'
    fill_in('Data prevista de entrega', with: '19/05/2022')
    click_on('Criar Pedido')

   
    expect(page).to have_content("Não foi possível cadastrar o pedido")
    expect(page).to have_content('Data prevista de entrega deve ser futura')
    

  end
end