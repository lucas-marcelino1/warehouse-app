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
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now, status: 'delivered')
    @third_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now, status: 'canceled')

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')

    expect(page).to have_content(@first_order.code)
    expect(page).to have_content('Pendente')
    expect(page).not_to have_content(@second_order.code)
    expect(page).not_to have_content('Entregue')
    expect(page).to have_content(@third_order.code)
    expect(page).to have_content('Cancelado')
  end

  it 'e visita o pedido' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')

    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @third_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on("#{@first_order.code}")
    @estimated_delivery_date = I18n.localize(1.day.from_now.to_date, format: :long)

    expect(page).to have_content("Pedido - #{@first_order.code}")
    expect(page).to have_content("#{@first_order.code}")
    expect(page).to have_content('Galpão destino: Rio | SDU')
    expect(page).to have_content('Fornecedor: Samsung Brasil LTDA - Samsung | 12.345.678/1000-10.')
    expect(page).to have_content('Responsável: Lucas <lucas@gmail.com>')
    expect(page).to have_content("Data prevista de entrega: #{@estimated_delivery_date}")
  
  end

  it 'e não consegue visitar os pedidos de outros usuário' do

    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @second_user = User.create!(name: 'João Almdeida', email: 'joão@gmail.com', password: '12345678')

    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @first_order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    @second_order = Order.create!(user: @second_user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.week.from_now)

    login_as(@user, :scope => :user)
    visit(order_path(@second_order.id))

    expect(current_path).not_to eq(order_path(@second_order.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Não foi possível realizar a ação!')

  end

  it 'e vê os itens do pedido' do

    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    product_A = ProductModel.create!(name: 'Produto A', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODA-SAMSU-XPTZXO90', supplier: @supplier)
    product_B = ProductModel.create!(name: 'Produto B', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODB-SAMSU-XPTZXO90', supplier: @supplier)
    product_C = ProductModel.create!(name: 'Produto C', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODC-SAMSU-XPTZXO90', supplier: @supplier)
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    OrderItem.create!(product_model: product_A, order: @order, quantity: 23)
    OrderItem.create!(product_model: product_C, order: @order, quantity: 11)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on("#{@order.code}")

    expect(page).to have_content('Itens do pedido')
    expect(page).to have_content('23 itens do Produto A')
    expect(page).to have_content('11 itens do Produto C')



  end



end