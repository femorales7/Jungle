class LineItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  def total_price
    product.price * quantity
  end

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end
