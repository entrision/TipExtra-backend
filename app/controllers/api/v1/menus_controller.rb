class Api::V1::MenusController < Api::V1::BaseController
  before_filter :correct_user, only: [:update]
  skip_before_filter :authenticate_api_user!, except: [:update]

  def index
    menus = Menu.all
    respond_with menus, each_serializer: MenusSerializer
  end

  def show
    respond_with menu
  end

  def update
    menu.update(menu_params)
    render json: menu, status: 200
  end

  private

  def menu
    Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:service_enabled)
  end

  def correct_user
    access_denied and return unless current_user?(menu.user)
  end
end
