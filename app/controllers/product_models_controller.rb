class ProductModelsController < ApplicationController

    def index
        @product_models = ProductModel.all
    end

    def new
        @product_model = ProductModel.new
        @suppliers_ordened = Supplier.order(:name)
    end

    def create
        
        @product_model = ProductModel.new(params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id))
        if @product_model.save

            redirect_to(product_models_path, notice: 'Modelo de produto cadastrado com sucesso!')
        else
            @suppliers_ordened = Supplier.order(:name)
            flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto!'
            render 'new'
        end
    end

    def show
        @product_model = ProductModel.find(params[:id])
    end

    

   
end
