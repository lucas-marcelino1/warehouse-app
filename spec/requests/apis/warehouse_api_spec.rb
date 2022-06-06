require 'rails_helper' 

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do

    it 'sucess' do
      #Arrange
      warehouse = Warehouse.create(name: 'Aeroporto de SP', cod: 'GRU', city: 'São Paulo', area: 90_000,
        address: 'Avenida do aeroporto, 498', cep: '84875-687',
        description: 'Armazém destinado à mercadorias internacionais')

      #Act
      get("/api/v1/warehouses/#{warehouse.id}")

      #Assert
      # expect(response).to have_http_status() mesma coisa que de baixo
      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body) ## NO TRÁFICO DE JSON ELE É TRANSFORMADO EM STRING, ESTE MÉTODO TRANSFORMA PARA UM HASH (SIMILAR AO JSON)
      expect(json_response["name"]).to eq('Aeroporto de SP')
      expect(json_response["cod"]).to eq('GRU')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')

      # expect(response.body).to include('Aeroporto de SP')
    end

    # cada operação da api é um endpoint
    it 'fail if warehouse not found' do

      get("/api/v1/warehouses/999998888888877777777")

      expect(response.status).to eq 404
    end

  end

  context 'GET /api/v1/warehouses' do
    it 'sucess' do
      Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
      Warehouse.create!(name: 'Maceio', cod: 'MCZ', city: 'Maceió', area: 60_000, cep: '45000-200', address: 'Av Maceió', description: 'Galpão de Maceió')
    
      get("/api/v1/warehouses")

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array #essa linha não é comum
      expect(json_response.length).to eq 2
      expect(json_response.first["name"]).to eq('Rio')
      expect(json_response.last["name"]).to eq('Maceio')
      expect(json_response.first.keys).not_to include('created_at')
    end

    it 'return empty there is no warehouses' do

      get("/api/v1/warehouses")

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'fail if there is an internal error' do
      
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled) ## Funciona para o rescue_from pois QueryCancelede herda de ActiveRecordError
      Warehouse.create!(name: 'Rio', cod: 'SDU', city: 'Rio de Janeiro', area: 50_000, cep: '20000-000', address: 'Av do Porto do Rio', description: 'Galpão do Rio')
      Warehouse.create!(name: 'Maceio', cod: 'MCZ', city: 'Maceió', area: 60_000, cep: '45000-200', address: 'Av Maceió', description: 'Galpão de Maceió')

      get("/api/v1/warehouses")

      expect(response.status).to eq(500)
    end

  end

  context 'POST /api/v1/warehouses' do

    it 'success' do

      #payload são as informações enviadas para postar no servidor
      post('/api/v1/warehouses', params: {warehouse: {name: 'Galpão Joinville', cod: 'JVE', city: 'Joinville', area: 90_000, cep: '89026-500', address: 'Rua Bernardino - 540', description: 'Galpão de SC na cidade de Joinville'}})

      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Galpão Joinville')
      expect(json_response["cod"]).to eq('JVE')
      expect(json_response["city"]).to eq('Joinville')
      expect(json_response["area"]).to eq(90000)
      expect(json_response["cep"]).to eq('89026-500')
      expect(json_response["address"]).to eq('Rua Bernardino - 540')
      expect(json_response["description"]).to eq('Galpão de SC na cidade de Joinville')

    end

    it 'fail if parameters are not complete' do
    
      post('/api/v1/warehouses', params: {warehouse: {name: 'Galpão Joinville', cod: 'JVE'}})

      expect(response.status).to eq(412)
      expect(response.body).not_to include('Nome não pode ficar em branco')
      expect(response.body).not_to include('Código não pode ficar em branco')
      expect(response.body).to include('Área não pode ficar em branco')
      expect(response.body).to include('Cidade não pode ficar em branco')
      expect(response.body).to include('Endereço não pode ficar em branco')
      expect(response.body).to include('CEP não pode ficar em branco')
      expect(response.body).to include('CEP não é válido')
      expect(response.body).to include('Descrição não pode ficar em branco')


    end

    it 'fail if there is an internal error' do
      #fazer um mock, interferir na execução do código utilizando métodos do Rspec para disparar um erro
      #Gera o erro na hora do Warehouse.new(params)
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      
      warehouse_params = {warehouse: {name: 'Galpão Joinville', cod: 'JVE', city: 'Joinville', area: 90_000, cep: '89026-500', address: 'Rua Bernardino - 540', description: 'Galpão de SC na cidade de Joinville'}}

      post('/api/v1/warehouses', params: warehouse_params)

      expect(response.status).to eq(500)
    end

  end


end