require 'csv'
require_relative 'config/application'

Rails.application.load_tasks

task seed_database: ["seed_database:import_customers",
                     "seed_database:import_merchants",
                     "seed_database:import_invoices",
                     "seed_database:import_items",
                     "seed_database:import_invoice_items",
                     "seed_database:import_transactions"]

namespace :seed_database do
  task :import_customers => :environment do
    csv_text = File.read("./db/seed/customers.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Customer.create!(row.to_h)
    end
  end

  task :import_merchants => :environment do
    csv_text = File.read("./db/seed/merchants.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Merchant.create!(row.to_h)
    end
  end

  task :import_invoices => :environment do
    csv_text = File.read("./db/seed/invoices.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Invoice.create!(row.to_h)
    end
  end

  task :import_items => :environment do
    csv_text = File.read("./db/seed/items.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Item.create!(row.to_h)
    end
  end

  task :import_invoice_items => :environment do
    csv_text = File.read("./db/seed/invoice_items.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  task :import_transactions => :environment do
    csv_text = File.read("./db/seed/transactions.csv")
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Transaction.create!(row.to_h)
    end
  end
    
end
