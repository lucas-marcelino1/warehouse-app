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

  end
end