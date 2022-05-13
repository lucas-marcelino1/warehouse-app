class SuppliersController < ApplicationController
    before_action :set_id, only: [:show, :edit, :update]
    

    def index
        @suppliers = Supplier.all
    end

    def new
        @supplier = Supplier.new
        
    end

    def show
        
    end

    def edit
        
    end

    def update
        
        if @supplier.update(supplier_params)
            redirect_to(supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso')
        else
            flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
            render :edit
        end
    end

    def create
        @supplier = Supplier.new(supplier_params)

        if @supplier.save
            redirect_to(suppliers_path, notice: 'Fornecedor cadastrado com sucesso.')
        else
            flash.now[:notice] = 'Não foi possível cadastrar o fornecedor!'
            render :new
        end
    end

    private

    def set_id
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params
        params.require(:supplier).permit(:corporation_name, :brand_name, :registration_number,
            :city, :email, :state, :address)
    end
end