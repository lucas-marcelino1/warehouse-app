class OrderItemsController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order = Order.find(params[:order_id])
    order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)
    if @order.order_items.create(order_item_params)
      redirect_to(@order, notice: 'Item adicionado com sucesso')  
    else
      flash.now[:notice] = 'Não foi possível adicionar o item'
      render 'new'
    end
  end

end