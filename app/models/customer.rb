class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def self.find_invoice_customer(invoice_id)
    joins(:invoices).where("invoices.id = #{invoice_id}").first
  end
  
  def self.favorite_merchant(id)
    Merchant.select('merchants.*, count(transactions.id) as merchant_transactions')
            .joins(:invoices, invoices: :transactions)
            .where(invoices: {customer_id: id})
            .where(transactions: {result: "success"})
            .group(:id)
            .order('merchant_transactions DESC')
            .limit(1)[0]
  end
end
