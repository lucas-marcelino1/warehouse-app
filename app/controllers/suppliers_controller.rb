class SuppliersController < ApplicationController

    def index
        @suppliers = Supplier.all
    end

    def new
        @supplier = Supplier.new
    end

    def show
        @supplier = Supplier.find(params[:id])
    end

    def edit
        @supplier = Supplier.find(params[:id])
    end

    def update
        @supplier = Supplier.find(params[:id])
        if @supplier.update(params.require(:supplier).permit(:corporation_name, :brand_name, :registration_number,
            :city, :email, :state, :address))
            redirect_to(supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso')
        else
            flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
            render :edit
        end
    end

    def create
        @supplier = Supplier.new(params.require(:supplier).permit(:corporation_name, :brand_name, :registration_number,
                      :city, :email, :state, :address))

        if @supplier.save
            redirect_to(suppliers_path, notice: 'Fornecedor cadastrado com sucesso.')
        else
            flash.now[:notice] = 'Não foi possível cadastrar o fornecedor!'
            render :new
        end
    end
end