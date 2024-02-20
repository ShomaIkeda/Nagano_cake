class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :orders
  has_many :order_details

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width,height]).processed
  end

def with_tax_price
  (price_excluding_tax * 1.1).floor
end

end
