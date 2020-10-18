# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# desc "Import csv data"
# task import_data: :environment do
  Customer.destroy_all
  Merchant.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  InvoiceItem.destroy_all
  Transaction.destroy_all

  puts 'Database tables reset.'

  puts 'Importing customers'
  CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
    Customer.create!({
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "customers.csv imported"

  puts 'Importing merchants'
  CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    Merchant.create!({
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "merchants.csv imported"

  puts 'Importing items'
  CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!({
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price].to_f / 100,
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "items.csv imported"

  puts 'Importing invoices'
  CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
    Invoice.create!({
        id: row[:id],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        status: row[:status],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "invoices.csv imported"

  puts 'Importing invoice items'
  CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!({
        id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        quantity: row[:quantity],
        unit_price: row[:unit_price].to_f / 100,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "invoice_items.csv imported"

  puts 'Importing transactions'
  CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
    Transaction.create!({
        id: row[:id],
        invoice_id: row[:invoice_id],
        credit_card_number: row[:credit_card_number],
        credit_card_expiration_date: row[:credit_card_expiration_date],
        result: row[:result],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
  end
  puts "transactions.csv imported"
