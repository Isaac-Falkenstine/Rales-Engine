class Api::V1::Merchants::FavoritesController < ApplicationController
  def show
    render json: CustomerSerializer.new(Merchant.favorite_customer(params[:id]))
  end
end
