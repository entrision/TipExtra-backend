class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_filter :authenticate_api_user!, only: [:create]

  def create
    user = User.find_by_email(params[:user][:email])
    render json: { 'errors': { 'login': ['Invalid email or password']  }  }, status: 401 and return if user.nil?

    if user.valid_password?(params[:user][:password])
      user.save
      render json: user
    else
      render json: { 'errors': { 'login': ['Invalid email or password']  }  }, status: 401
    end
  end

  def destroy
    if current_user.update_column(:authentication_token, nil)
      head :no_content
    else
      render json: { error: 'Sign out failed'  }, status: 403
    end
  end
end
