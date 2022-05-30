require 'rails_helper'

describe 'Usuário atualiza pedido' do

  it 'e não é o responsável' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)

    login_as(@user, :scope => :user)
    post(delivered_order_path(@second_order.id))
    
    expect(response).to redirect_to(root_path)
  end

  it 'e não é o responsável' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)

    login_as(@user, :scope => :user)
    post(canceled_order_path(@second_order.id))
    
    expect(response).to redirect_to(root_path)
  end


end