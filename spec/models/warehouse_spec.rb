require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    describe '#valid?' do

    context 'presence of attributes' do
        it 'false when name is empty' do
            #Arrange
            warehouse = Warehouse.new(name: '', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)

            #Outras formas
            # expect(warehouse.valid?).to eq(false) -> Já coloca a act dentro do assert
            # expect(warehouse).not_to be_valid -> Executa o método valid? e espera que não seja true
            # expect(result).to be_falsey -> aceita nil ou false
        end

        it 'false when cod is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: '', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end

        it 'false when city is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: 'SDU', city: '', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end

        it 'false when area is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: '', cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end

        it 'false when cep is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end

        it 'false when address is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: '', description: 'Galpão do Rio')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end

        it 'false when description is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: '')
            
            #Act
            result = warehouse.valid?
            
            #Assert
            expect(result).to eq(false)
        end
    end
        
        it 'false when cod is already in use' do
            #Arrange
            first_warehouse = Warehouse.create(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000',
                                            address: 'Av do Porto do Rio', description: 'Galpão do Rio')

            second_warehouse = Warehouse.create(name: 'Niterói', cod: 'SDU', city: 'São Paulo', area: 60_000, cep: '68000-000',
                                            address: 'Av Casa Branca', description: 'Galpão de Niterói')
            #Act
            result = second_warehouse.valid?

            #Assert
            expect(result).to eq(false)
        end

    end
end
