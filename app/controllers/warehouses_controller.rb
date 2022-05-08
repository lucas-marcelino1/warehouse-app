class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
		@warehouse = Warehouse.new
    end

    def create
		@warehouse = Warehouse.new(params.require(:warehouse).permit(:name, :city, :cod, :address, :description, :area, :cep))
        
		if @warehouse.save #executa o método valid?
			redirect_to(root_path, notice: 'Galpão cadastrado com sucesso.')
		else
			flash.now[:notice] = 'Não foi possível cadastrar galpão.'
			render 'new'
		end
    end

	def edit
		@warehouse = Warehouse.find(params[:id])
	end

	def update
		@warehouse = Warehouse.find(params[:id])
		if @warehouse.update(params.require(:warehouse).permit(:name, :city, :cod,:address, :description, :area, :cep))
			redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
		else
			flash.now[:notice] = 'Não foi possível atualizar o galpão'
			render 'edit'
		end
	end
	
end