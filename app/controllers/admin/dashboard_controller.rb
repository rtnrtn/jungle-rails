class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: Rails.configuration.http_basic_auth[:name], password: Rails.configuration.http_basic_auth[:password]
  
  def show
    @product_count = Product.count()
    @category_count = Category.count()
    @categories = Category.all
  end
end
