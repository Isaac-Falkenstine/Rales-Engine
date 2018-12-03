class Api::V1::InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]))
    elsif params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.where(customer_id: params[:customer_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if params[:invoice_item_id]
      render json: InvoiceSerializer.new(Invoice.find_invoice_item(params[:invoice_item_id]))
    elsif params[:transaction_id]
      render json: InvoiceSerializer.new(Invoice.find_transaction(params[:transaction_id]))
    else
      render json: InvoiceSerializer.new(Invoice.find(params[:id]))
    end
  end
end
