class User < ActiveRecord::Base

  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create, length: { minimum: 10 }
  validates :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true,
    unless: Proc.new { |a| a.password.blank? }
  
  before_validation do
    self.email = email.downcase
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    user && user.authenticate(password) ? user : nil
  end

end
