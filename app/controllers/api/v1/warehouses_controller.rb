class Api::V1::WarehousesController < ActionController::API

  def show

    begin #begin e rescue é utilizado caso o código dê algum erro
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    # render status: 200, json: warehouse - Dessa maneira ele já consegue converter para json automaticamente
    # render status: 200, json: "{#{warehouse}}" converte para json automaticamente
    rescue 
      return render status: 404
    end

  end

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:created_at, :updated_at])
  end

end