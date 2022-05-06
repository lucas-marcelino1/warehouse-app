class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
		@warehouse = Warehouse.new
    end

    def create
		@warehouse = Warehouse.new(params.require(:warehouse).permit(:name, :city, :cod, :address, :description, :area, :cep))
        
		if @warehouse.save
			redirect_to(root_path, notice: 'Galpão cadastrado com sucesso.')
		else
			flash.now[:notice] = 'Não foi possível cadastrar galpão.'
			render 'new'
		end
        
    end
end