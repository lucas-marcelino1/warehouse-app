require 'rails_helper'

RSpec.describe Supplier, type: :model do


    describe '#valid?' do

        it 'falso quando o campo Razão Social está vazio' do

            @supplier = Supplier.create(corporation_name: '', brand_name: 'Inox', registration_number: '12345679/9874',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end


        it 'falso quando o campo CNPJ está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end

        it 'falso quando o campo CNPJ está no formato incorreto' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/100-10',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end

        it 'falso quando o CNPJ já está em uso' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            @second_supplier = Supplier.create(corporation_name: 'Volpato', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                        address: 'Rua General Osório, 788', city: 'Curitiba', state: 'Paraná', email: 'volpatocontato@gmail.com')
            result = @second_supplier.valid?

            expect(result).to eq(false)
        end

        it 'falso quando o campo Endereço está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                         address: '', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end

        it 'falso quando o campo Cidade está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                         address: 'Rua Progresso, 2548', city: '', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end

        it 'falso quando o campo Estado está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: '', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(false)
        end


        it 'falso quando o campo E-mail está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: 'Inox', registration_number: '12.345.678/1000-10',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: '')

            result = @supplier.valid?

            expect(result).to eq(false)
        end

        it 'verdadeiro quando o campo Nome Fantasia está vazio' do

            @supplier = Supplier.create(corporation_name: 'Inox Brasil LTDA', brand_name: '', registration_number: '12.345.678/1000-10',
                                         address: 'Rua Progresso, 2548', city: 'Blumenau', state: 'Santa Catarina', email: 'inoxbrasilcontato@inox.com.br')

            result = @supplier.valid?

            expect(result).to eq(true)
        end

    end
 
end
