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

  def self.best_day(id)
    Invoice.select("invoices.created_at AS best_day, sum(invoice_items.quantity) AS units")
    .joins(:invoice_items)
    .where("invoice_items.item_id = #{id}")
    .group("invoices.id")
    .order("units desc, invoices.created_at desc")
    .limit(1).first
  end
end
