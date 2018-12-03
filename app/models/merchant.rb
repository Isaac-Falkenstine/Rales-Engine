class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.find_merchant_invoice(invoice_id)
    joins(:invoices).where("invoices.id = #{invoice_id}").first
  end

  def self.merchant_item(item_id)
    joins(:items).where("items.id = #{item_id}").first
  end

  def self.most_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end
end
