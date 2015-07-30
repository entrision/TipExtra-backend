class Api::V1::BraintreeController < Api::V1::BaseController
  def get_token
    render json: { token: Braintree::ClientToken.generate }, status: 200
  end

  def payment_nonce
    current_user.braintree_create_payment_method(nonce_params['nonce'])
    head :created
  end

  private

  def nonce_params
    params.require(:payment).permit(:nonce)
  end
end
