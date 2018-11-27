class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :items
  belongs_to :invoices
end
