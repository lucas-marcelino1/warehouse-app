require 'rails_helper'

RSpec.describe StockProduct, type: :model do
 describe 'gera número de série único automaticamente' do
  it'ao criar um produto de estoque' do
    ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
      address: 'Avenida do aeroporto, 498', cep: '84875-687',
      description: 'Armazém destinado à mercadorias internacionais')
    sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')
    order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
    product_model = ProductModel.create!(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 2, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: sup)
    stock_product = StockProduct.create!(product_model: product_model, warehouse: ware, order: order)
    
    expect(stock_product.serial_number).not_to be_empty
    expect(stock_product.serial_number.length).to eq 20
  end

  it 'e permaneçe inalterado' do
    ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
      address: 'Avenida do aeroporto, 498', cep: '84875-687',
      description: 'Armazém destinado à mercadorias internacionais')
    second_ware = Warehouse.create!(name: 'Rio de Janeiro', cod: 'SDR', city: 'Rio de Janeiro', area: 120_000,
        address: 'Avenida cruzeiro, 79', cep: '84887-687',
        description: 'Armazém de produtos do rio de janeiro')
    sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')
    order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
    product_model = ProductModel.create!(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 2, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: sup)
    stock_product = StockProduct.create!(product_model: product_model, warehouse: ware, order: order)
    serial_number = stock_product.serial_number
    
    stock_product.update!(warehouse: second_ware)
    
    expect(stock_product.serial_number).to eq serial_number
  end
 end

 describe '#available' do
  it 'true quando está disponível' do
    ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
      address: 'Avenida do aeroporto, 498', cep: '84875-687',
      description: 'Armazém destinado à mercadorias internacionais')
    sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')
    order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
    product_model = ProductModel.create!(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 2, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: sup)
    stock_product = StockProduct.create!(product_model: product_model, warehouse: ware, order: order)
    
    result = stock_product.available

    expect(result).to eq(true)
  end

  it 'false quando não está disponível' do
    ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
      address: 'Avenida do aeroporto, 498', cep: '84875-687',
      description: 'Armazém destinado à mercadorias internacionais')
    sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')
    order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
    product_model = ProductModel.create!(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 2, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: sup)
    stock_product = StockProduct.create!(product_model: product_model, warehouse: ware, order: order)
    stock_product.create_stock_product_destination!(recipient: 'Lucas', address: 'Aveniada Ituporanga')
    
    result = stock_product.available

    expect(result).to eq(false)

  end
 end
end
