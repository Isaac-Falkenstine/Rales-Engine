class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_id]
      render json: ItemSerializer.new(Item.invoice_for_item(params[:invoice_id]))
    else
      render json: ItemSerializer.new(Item.all)
   end
 end


  def show
    render json: Item.find(params[:id])
  end
end
