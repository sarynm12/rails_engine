class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).where(transactions: {result: "success"}, invoices: {status: "shipped"}).group(:id).order('revenue desc').limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.select("merchants.*, SUM(invoice_items.quantity) AS sold").joins(:invoice_items, :transactions).where(transactions: {result: "success"}, invoices: {status: "shipped"}).group(:id).order('sold desc').limit(quantity)
  end
end
