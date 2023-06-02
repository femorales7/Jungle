class ApplicationController < ActionController::Base
  before_action :authenticate, if: :admin_namespace?
  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.configuration.admin_username && password == Rails.configuration.admin_password
    end
  end

  def skip_authentication?
    exempt_controllers = ['admin/dashboard', 'admin/products'] # Add controllers that don't require authentication here
    exempt_controllers.include?(controller_path) || controller_path == 'carts#show'
  end
  def admin_namespace?
    controller_path.starts_with?('admin/')
  end
end
