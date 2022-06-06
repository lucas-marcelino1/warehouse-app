class Api::V1::WarehousesController < Api::V1::ApiController
  # rescue_from ActiveRecord::ActiveRecordError, with: :return_status_500
  # rescue_from ActiveRecord::RecordNotFound, with: :return_status_404
  ## Utilizado no lugar de begin e rescue dentro da action, quando o erro pode acontecer em mais actions (A ordem deles importa, sendo do mais génerico para o mais específico)

  def show
    # begin -> begin e rescue é utilizado caso o código dê algum erro
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    # rescue 
      # return render status: 404
    # end
  end

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:created_at, :updated_at])
  end

  def create
    warehouse = Warehouse.new(params.require(:warehouse).permit(:name, :city, :cod, :address, :description, :area, :cep))
    if warehouse.save
      render status: 201, json: warehouse.as_json(except: [:created_at, :updated_at])
    else
      render status: 412, json: {errors: warehouse.errors.full_messages}.as_json
    end
  end

  # private
# 
  # def return_status_500
  #   render status: 500
  # end
# 
  # def return_status_404
  #   render status: 404
  # end
  # //////////// Foi criado um API controller para lidar com estas situações.
end