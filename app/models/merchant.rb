class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    Merchant.joins(:invoice_items).joins(:invoices).joins(:transactions)
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group_by(merchants.id)
    .limit(quantity)
    # Merchant.select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    # .joins(invoices: :items).joins(invoices: :transactions)
  end
end
