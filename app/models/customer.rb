class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def self.find_invoice_customer(invoice_id)
    joins(:invoices).where("invoices.id = #{invoice_id}").first
  end
end
