require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do

    it 'deve ter um código' do
      ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
        address: 'Avenida do aeroporto, 498', cep: '84875-687',
        description: 'Armazém destinado à mercadorias internacionais')
      sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
        address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
      u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')
      @order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: '2022-10-01')

      result = @order.valid?

      expect(result).to be true
    end

    it 'data estimada deve ser obrigatória' do
      @order = Order.new(estimated_delivery_date: '')

      @order.valid?

      expect(@order.errors.include? :estimated_delivery_date).to be true # Como este teste é mais pontual
                                                                         # É preciso somente testar o campo
    end

    it 'data estimada não deve ser antiga' do
      @order = Order.new(estimated_delivery_date: 1.day.ago)

      @order.valid?

      expect(@order.errors.include? :estimated_delivery_date).to be true 
      expect(@order.errors[:estimated_delivery_date]).to include('deve ser futura')
    end

    it 'data estimada não deve ser hoje' do
      @order = Order.new(estimated_delivery_date: Date.today)

      @order.valid?

      expect(@order.errors.include? :estimated_delivery_date).to be true 
      expect(@order.errors[:estimated_delivery_date]).to include('deve ser futura')
    end

    it 'data estimada deve ser igual ou maior que amanhã' do
      @order = Order.new(estimated_delivery_date: 1.day.from_now)

      @order.valid?

      expect(@order.errors.include? :estimated_delivery_date).to be false 
    end
  end


  describe 'gera um código aleatório' do

    it 'ao criar um novo pedido' do
      ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
                            address: 'Avenida do aeroporto, 498', cep: '84875-687',
                            description: 'Armazém destinado à mercadorias internacionais')
      sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
      u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')

      @order = Order.new(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
      
      @order.save!
      result = @order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8

    end

    it 'e o código seja único' do
      ware = Warehouse.create!(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
                            address: 'Avenida do aeroporto, 498', cep: '84875-687',
                            description: 'Armazém destinado à mercadorias internacionais')
      sup = Supplier.create!(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                            address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
      u = User.create!(email: 'lucas.marcelino@email.com', password: '123456', name: 'Lucas')

      @first_order = Order.create!(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)
      @second_order = Order.new(warehouse: ware, supplier: sup, user: u, estimated_delivery_date: 1.day.from_now)

      @second_order.save!

      expect(@second_order.code).not_to eq(@first_order.code)
      

    end

  end
end
