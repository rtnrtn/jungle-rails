Rails.configuration.http_basic_auth = {
  :name => ENV['HTTP_BASIC_USER'],
  :password => ENV['HTTP_BASIC_PASSWORD']
}
