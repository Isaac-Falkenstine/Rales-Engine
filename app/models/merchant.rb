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
end
