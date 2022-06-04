class StockProductDestinationsController < ApplicationController

  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = ProductModel.find(params[:product_model_id])
    stock_product = StockProduct.where(product_model: product_model, warehouse: warehouse).where.missing(:stock_product_destination).first
    #stock_product = StockProduct.find_by(product_model: product_model, warehouse: warehouse) TROQUEI PELO DE CIMA PARA PODER RETIRAR VÁRIOS PRODUTOS

    if stock_product != nil && stock_product.available == true
      stock_product.create_stock_product_destination!(recipient: params[:recipient], address: params[:address])
    #cria um stock product destination com associação imediata ao stock product
    redirect_to(warehouse, notice: 'Item despachado com sucesso!')
    else
      redirect_to(warehouse, notice: 'Não foi possível despachar o item!')
    end
    

  end

end