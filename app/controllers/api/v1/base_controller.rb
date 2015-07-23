module Api
  module V1
    class BaseController < ApplicationController
      before_filter :authenticate_api_user!

      def access_denied
        render json: { message: 'Access Denied' }, status: 403
      end

      private

      def authenticate_api_user!
        authenticate_with_http_token do |token|
          @user = User.find_by_authentication_token(token)
        end
        if @user.nil?
          render json: { message: "Invalid Token. Please reauthenticate." }, status: 403 and return
        end
      end

      def current_user
        @user
      end

      def current_user?(user)
        @user == user
      end

    end
  end
end
