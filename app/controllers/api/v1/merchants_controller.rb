class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:invoice_id]
      render json: MerchantSerializer.new(Merchant.find_merchant_invoice(params[:invoice_id]))
    elsif params[:item_id]
      render json: MerchantSerializer.new(Merchant.merchant_item(params[:item_id]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end
end
