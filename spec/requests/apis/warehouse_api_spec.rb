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
      # expect(response).to have_http_status()
      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body) ## NO TRÁFICO DE JSON ELE É TRANSFORMADO EM STRING, ESTE MÉTODO TRANSFORMA PARA UM HASH (SIMILAR AO JSON)
      expect(json_response["name"]).to eq('Aeroporto de SP')
      expect(json_response["cod"]).to eq('GRU')


      
      # expect(response.body).to include('Aeroporto de SP')


    end

  end
end