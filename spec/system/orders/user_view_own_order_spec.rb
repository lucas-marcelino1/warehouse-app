require 'rails_helper'

describe 'Usuário visita seus próprios pedidos' do

  it 'e deve estar autenticado' do

    visit(root_path)

    click_on('Meus Pedidos')
    expect(current_path).to eq(new_user_session_path)

  end

  it 'e visualiza os pedidos com sucesso' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')

    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)
    @third_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')

    expect(page).to have_content(@first_order.code)
    expect(page).not_to have_content(@second_order.code)
    expect(page).to have_content(@third_order.code)


  end

end