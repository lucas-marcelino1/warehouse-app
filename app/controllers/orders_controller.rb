class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:name)
    @order = Order.new
  end

  def create
    @order_user = current_user
    @order = Order.new(params.require(:order).permit(:estimated_delivery_date, :warehouse_id, :supplier_id).merge(user_id: @order_user.id))
    if @order.save
      flash[:notice] = 'Pedido realizado com sucesso!'
      redirect_to(@order) 
    else
      flash.now[:notice] = "Não foi possível"
      
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end