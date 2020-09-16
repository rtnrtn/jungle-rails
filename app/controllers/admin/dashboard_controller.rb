class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: Rails.configuration.http_basic_auth[:name], password: Rails.configuration.http_basic_auth[:password]
  
  def show
  end
end
