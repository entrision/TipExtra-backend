class Api::V1::BraintreeController < Api::V1::BaseController
  def get_token
    render json: { token: Braintree::ClientToken.generate }, status: 200
  end
end
