class CategoriesController < ApplicationController
  before_action :authenticate, if: :admin_namespace?

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
