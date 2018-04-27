class Review < ActiveRecord::Base
  belongs_to :product
  validates :user_id, :product_id, :description, presence: true
  validates :rating, :inclusion => 1..5
end
