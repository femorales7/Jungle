class ProductsController < ApplicationController
  before_action :authenticate, if: :admin_namespace?

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end
