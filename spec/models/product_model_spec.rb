require 'rails_helper'

RSpec.describe ProductModel, type: :model do

    describe '#valid?' do

        it 'falso quando nome está vazio' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: '', weight: 2000, width: 70, height: 45, depth: 10, sku:'TV32I-SAMSU-XPTZXO90', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end

        it 'falso quando peso está vazio' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-32 polegadas', weight: '', width: 70, height: 45, depth: 10, sku:'TV32I-SAMSU-XPTZXO90', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end

        it 'falso quando largura está vazio' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-32 polegadas', weight: 2000, width: '', height: 45, depth: 10, sku:'TV32I-SAMSU-XPTZXO90', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end


        it 'falso quando codigo é menor que 20' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 45, depth: 10, sku:'TV32I-SAMU-XPTZXO90', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end

        it 'falso quando peso é menor ou igual a 0' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-Samsung 32in', weight: -1, width: 70, height: 45, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end

        it 'falso quando largura é menor ou igual a 0' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-Samsung 32in', weight: 2000, width: 0, height: 45, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end


        it 'falso quando altura é menor ou igual a 0' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: -2, depth: 10, sku:'TV32I-SAMU-XPTZZERXO', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end

        it 'falso quando profundidade é menor ou igual a 0' do

            @supplier = Supplier.create!(corporation_name: 'Samsung Brasil LTDA', brand_name: 'Samsung', registration_number: '12.345.678/1000-10',
                address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')
    
            @product = ProductModel.create(name: 'TV-Samsung 32in', weight: 2000, width: 70, height: 20, depth: 0, sku:'TV32I-SAMU-XPTZZERXO', supplier: @supplier)
            
            result = @product.valid?

            expect(result).to eq(false)
        
        end
    end
  
end
