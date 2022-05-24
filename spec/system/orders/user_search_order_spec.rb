require 'rails_helper'

describe 'Usuário pesquisa pedido' do
  it 'e deve estar autenticado' do
    
    visit(root_path)

    within 'header nav' do
      expect(page).not_to have_field('Procurar pedido')
      expect(page).not_to have_button('Buscar')
    end

  end
  
  it 'a partir do menu' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')

    login_as(@user, :scope => :user)
    visit(root_path)

    within 'header nav' do
      expect(page).to have_field('Procurar pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    @user = User.create!(name: 'Lucas', email: 'lucas@gmail.com', password: '12345678')
    @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
      address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'samsungbrasilcontato@gmail.com.br')
    Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.689.678/1000-10',
        address: 'Rua João Pessoa, 337', city: 'Aracuari', state: 'Pará', email: 'inoxbrasilcontato@inox.com.br')
    @warehouse = Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
    Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
          address: 'Avenida do aeroporto, 498', cep: '84875-687',
          description: 'Armazém destinado à mercadorias internacionais')
    @order = Order.create!(user: @user, warehouse: @warehouse, supplier: @supplier, estimated_delivery_date: 1.day.from_now)

    login_as(@user, :scope => :user)
    visit(root_path)

    within 'header nav' do
      fill_in('Procurar pedido', with: @order.code)
      click_on('Buscar')
    end

    expect(page).to have_content("Resultados da busca por: #{@order.code}")
    expect(page).to have_content('1 pedido encontrado')
    expect(page).to have_content("Código: #{@order.code}")
    expect(page).to have_content('Galpão destino: Rio | SDU')
    expect(page).to have_content('Fornecedor: Samsung Brasil LTDA')



  end
end