require 'rails_helper'

describe 'Usuário atualiza o status do pedido' do

  it 'para entregue' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on(@order.code)
    click_on('Marcar como ENTREGUE')

    expect(current_path).to eq(order_path(@order))
    expect(page).to have_content('Pedido marcado como entregue')
    expect(page).to have_content('Situação do pedido: Entregue')
    expect(page).not_to have_content('Marcar como ENTREGUE')


  

  end

  it 'para cancelado' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on(@order.code)
    click_on('Marcar como CANCELADO')

    expect(current_path).to eq(order_path(@order))
    expect(page).to have_content('Pedido marcado como cancelado')
    expect(page).to have_content('Situação do pedido: Cancelado')
    expect(page).not_to have_content('Marcar como CANCELADO')



  end

end