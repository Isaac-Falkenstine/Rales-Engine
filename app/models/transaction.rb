class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result

  belongs_to :invoice

  def self.transaction_customer(customer_id)
    joins(:invoice)
    .where("invoices.customer_id = #{customer_id}")
  end
end
