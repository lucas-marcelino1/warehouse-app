require 'rails_helper'

describe 'Usuário adiciona item ao pedido' do
  it 'com sucesso' do
    @user = User.new(name:'João', email: 'joão@gmail.com', password: '123456')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    product_A = ProductModel.create!(name: 'Produto A', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODA-SAMSU-XPTZXO90', supplier: @supplier)
    product_B = ProductModel.create!(name: 'Produto B', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODB-SAMSU-XPTZXO90', supplier: @supplier)
    product_C = ProductModel.create!(name: 'Produto C', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODC-SAMSU-XPTZXO90', supplier: @supplier)
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on("#{@order.code}")
    click_on("Adicionar Item")
    select('Produto A', from: 'Produto')
    fill_in('Quantidade', with: '8')
    click_on('Gravar')

    expect(current_path).to eq(order_path(@order))
    expect(page).to have_content('Item adicionado com sucesso')
    expect(page).to have_content('8 itens do Produto A')
  end

  it 'e não vê produtos de outros fornecedores' do
    @user = User.new(name:'João', email: 'joão@gmail.com', password: '123456')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @supplier_B = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.679/1000-10',
        address: 'Rua Jundiai, 998', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    product_A = ProductModel.create!(name: 'Produto A', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODA-SAMSU-XPTZXO90', supplier: @supplier)
    product_B = ProductModel.create!(name: 'Produto B', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODB-SAMSU-XPTZXO90', supplier: @supplier_B)
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)
    click_on('Meus Pedidos')
    click_on("#{@order.code}")
    click_on("Adicionar Item")

    expect(page).to have_content('Produto A')
    expect(page).not_to have_content('Produto B')

  end
end