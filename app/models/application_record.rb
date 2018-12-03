class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_invoice_item(inv_item_id)
    joins(:invoice_items).where("invoice_items.id = #{inv_item_id}").first
  end
end
