class Api::V1::CardsController < Api::V1::BaseController

  def create
  end

  private

  def card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_month, :expiration_year)
  end
end
