class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price
  belongs_to :merchant, dependent: :destroy
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
