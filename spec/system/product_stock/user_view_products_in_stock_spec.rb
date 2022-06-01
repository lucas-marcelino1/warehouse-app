require 'rails_helper' 

describe 'Usuário visualiza os produtos' do
  it 'em estoque no galpão' do
    @user = User.new(name:'João', email: 'joão@gmail.com', password: '123456')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    @supplier_B = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.679/1000-10',
        address: 'Rua Jundiai, 998', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    product_A = ProductModel.create!(name: 'Televisão XTO', weight: 2000, width: 70, height: 45, depth: 10, sku:'PRODA-SAMSU-XPTZXO90', supplier: @supplier)
    product_B = ProductModel.create!(name: 'Dinamic Audio 7.1', weight: 300, width: 50, height: 37, depth: 10, sku:'DINAM-SAMSU-HHYZXO71', supplier: @supplier_B)
    product_C = ProductModel.create!(name: 'Celular Samsung', weight: 200, width: 8, height: 7, depth: 3, sku:'CELUR-SAMSU-JJPZXO36', supplier: @supplier_B)
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)
    11.times do StockProduct.create!(product_model: product_A, warehouse: @warehouse, order: @order) end
    6.times do StockProduct.create!(product_model: product_B, warehouse: @warehouse, order: @order) end

    visit(root_path)
    click_on('Rio')
  

    expect(page).to have_content('Itens em Estoque')
    expect(page).to have_content('11 unidades - Televisão XTO/PRODA-SAMSU-XPTZXO90')
    expect(page).to have_content('6 unidades - Dinamic Audio 7.1/DINAM-SAMSU-HHYZXO71')
    expect(page).not_to have_content('Celular Samsung')

  end

end