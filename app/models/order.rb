class Order < ApplicationRecord
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  
    belongs_to :customer
    has_many :order_details
    has_many :items, through: :ordered_details 
  
  def with_tax_price
  (price_excluding_tax * 1.1).floor
  end

end
