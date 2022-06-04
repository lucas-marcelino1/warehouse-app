class WarehousesController < ApplicationController
	before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

    def show
			# @items = @warehouse.stock_products.group(:product_model).count -- Procura os stock products e agrupa por product model e conta
			@items = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count # procura onde a associação não existe
			@product_models = []
			@items.each do |stock_product_model|
				@product_models << stock_product_model.first
			end
    end

    def new
		@warehouse = Warehouse.new
    end

    def create
		@warehouse = Warehouse.new(warehouse_params)
        
		if @warehouse.save #executa o método valid?
			redirect_to(root_path, notice: 'Galpão cadastrado com sucesso.')
		else
			flash.now[:notice] = 'Não foi possível cadastrar galpão.'
			render 'new'
		end
    end

	def edit
	end

	def update

		if @warehouse.update(warehouse_params)
			redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
		else
			flash.now[:notice] = 'Não foi possível atualizar o galpão'
			render 'edit'
		end
	end

	def destroy
		@warehouse.destroy
		redirect_to(root_path, notice: 'Galpão removido com sucesso')
	end

	private

	def set_warehouse
		@warehouse = Warehouse.find(params[:id])
	end
	
	def warehouse_params
		params.require(:warehouse).permit(:name, :city, :cod,:address, :description, :area, :cep)
	end
end