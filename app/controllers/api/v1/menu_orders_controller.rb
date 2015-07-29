class Api::V1::MenuOrdersController < Api::V1::BaseController
  before_filter :correct_user

  def index
    render json: menu.orders, each_serializer: OrdersSerializer
  end

  def show
    respond_with order
  end

  def update
    order.update(order_params)
    render json: order, status: 200
  end

  private

  def menu
    Menu.find(params[:menu_id])
  end

  def order
    Order.find(params[:order_id])
  end

  def order_params
    params.require(:order).permit(:complete)
  end

  def correct_user
    access_denied and return unless current_user?(menu.user)
  end
end
