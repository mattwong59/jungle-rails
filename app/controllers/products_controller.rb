class ProductsController < ApplicationController

  def create
    @review = Review.new(review_params)
  end

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating,)
    end
end
