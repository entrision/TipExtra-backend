class Api::V1::MenusController < Api::V1::BaseController
  skip_before_filter :authenticate_api_user!

  def index
    menus = Menu.all
    respond_with menus, each_serializer: MenusSerializer
  end

  def show
    respond_with menu
  end

  private

  def menu
    Menu.find(params[:id])
  end
end
