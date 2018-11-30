class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find(Invoice.all.sample.id))
  end
end
