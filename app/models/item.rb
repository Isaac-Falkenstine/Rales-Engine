class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.invoice_for_item(invoice_id)
    joins(:invoice_items, :invoices)
    .where("invoices.id = #{invoice_id}")
    .group(:id)
  end
end
