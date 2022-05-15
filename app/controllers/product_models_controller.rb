class ProductModelsController < ApplicationController
    before_action :authenticate_user!, only: [:index]

    def index
        @product_models = ProductModel.all
    end

    def new
        @product_model = ProductModel.new
        @suppliers_ordened = Supplier.order(:name)
    end

    def create
        
        @product_model = ProductModel.new(product_model_params)
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

    def edit
        @product_model = ProductModel.find(params[:id])
        @suppliers_ordened = Supplier.order(:name)
    end

    def update
        @product_model = ProductModel.find(params[:id])
        if @product_model.update(product_model_params)
            redirect_to @product_model, notice: 'Modelo de produto atualizado com sucesso!'
        else
            @suppliers_ordened = Supplier.order(:name)
            flash.now[:notice] = 'Não foi possível atualizar o modelo de produto.'
            render 'new'
        end
    end

    private

    def product_model_params
        params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
    end

    

   
end
