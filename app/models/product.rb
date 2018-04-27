class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def is_sold_out?()
      quantity == 0
  end
end

  # puts "------------------_________------____________----------------------"
  # @sold_out = Product.where(quantity: 0)
  # @sold_out.each do |product|
  #   puts "Sold out product: #{product.name}"
  # end