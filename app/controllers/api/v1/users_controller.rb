class Api::V1::UsersController < Api::V1::BaseController
  before_filter :correct_user, only: [:update]

  def update
    user.update(user_params)
    render json: user, status: 200
  end

  private

  def user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, credit_card: [:number, :exp_month, :exp_year, :cvv])
  end

  def correct_user
    access_denied and return unless current_user?(user)
  end
end
