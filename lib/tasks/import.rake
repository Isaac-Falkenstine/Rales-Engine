namespace :import do
  desc "imports CSVs from /app/data"
  task :data => :environment do
    require 'csv'
    CSV.foreach('app/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_hash)
    end

    CSV.foreach('app/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_hash)
    end

    CSV.foreach('app/data/items.csv', headers: true) do |row|
      Item.create(row.to_hash)
    end

    CSV.foreach('app/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_hash)
    end

    CSV.foreach('app/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_hash)
    end

    CSV.foreach('app/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_hash)
    end

  end
end
