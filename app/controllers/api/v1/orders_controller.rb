class Api::V1::OrdersController < Api::V1::BaseController
  before_filter :correct_user, only: [:show]

  def index
    respond_with current_user.orders
  end

  def show
    respond_with order
  end

  def create
    order = Order.create(order_params)
    respond_with :api, :v1, order
  end

  private

  def order
    Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(line_items_attributes: [:qty, :drink_id]).merge(user: current_user)
  end

  def correct_user
    access_denied and return unless current_user?(order.user)
  end
end
