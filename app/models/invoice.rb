class Invoice < ApplicationRecord
  validates_presence_of :status

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant

  def self.find_transaction(tran_id)
    joins(:transactions)
    .where("transactions.id = #{tran_id}")
    .first
  end
end
