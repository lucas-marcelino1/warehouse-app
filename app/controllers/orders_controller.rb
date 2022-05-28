class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:update, :edit, :show]

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
      @warehouses = Warehouse.order(:name)
      @suppliers = Supplier.order(:name)
      flash.now[:notice] = "Não foi possível cadastrar o pedido"
      render 'new'
    end
  end

  def show
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def index
    @orders = current_user.orders
  end

  def edit
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:name)
  end

  def update
    if @order.update(params.require(:order).permit(:estimated_delivery_date, :warehouse_id, :supplier_id))
      return redirect_to(@order, notice: 'Pedido atualizado com sucesso.')
    else
      flash.now[:notice] = "Não foi possível atualizar o pedido."
      render 'edit'
    end
  end

  private
  
  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to(root_path, alert: 'Não foi possível realizar a ação!')
    end
  end
end