require 'rails_helper'

describe 'Usuário edita o pedido' do
  it 'e deve estar autenticado' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    
    visit(edit_order_path(@order.id))

    expect(current_path).not_to eq(edit_order_path(@order.id))
    expect(current_path).to eq(new_user_session_path)
  
  end

  it 'com sucesso' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')
    Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.689.678/1000-10',
      address: 'Rua João Pessoa, 337', city: 'Aracuari', state: 'Pará', email: 'inoxbrasilcontato@inox.com.br')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on("#{@first_order.code}")
    click_on('Editar')
    fill_in('Data prevista de entrega', with: '12/12/2022')
    select('Inox Brasil LTDA', from: 'Fornecedor')
    click_on('Atualizar Pedido')

    expect(page).to have_content('Pedido atualizado com sucesso.')
    expect(page).to have_content('Galpão destino: Rio | SDU')
    expect(page).to have_content('Fornecedor: Inox Brasil LTDA - Inox | 12.689.678/1000-10.')
    expect(page).to have_content('Data prevista de entrega: 12 de dezembro de 2022')
  end

  it 'falha se não for o responsável pelo pedido' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')
    Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.689.678/1000-10',
      address: 'Rua João Pessoa, 337', city: 'Aracuari', state: 'Pará', email: 'inoxbrasilcontato@inox.com.br')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)

    login_as(@user, :scope => :user)
    visit(edit_order_path(@second_order.id))
    

    expect(page).to have_content('Não foi possível realizar a ação!')
    
  end
end