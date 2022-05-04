class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new

    end

    def create
        w = Warehouse.new(params.require(:warehouse).permit(:name, :city, :cod, :address, :description, :area, :cep))
        w.save
        redirect_to(root_path, notice: 'Galpão cadastrado com sucesso.')
    end
end