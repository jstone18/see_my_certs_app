class User < ActiveRecord::Base

  has_secure_password

  has_many :user_certs
  has_many :certs, through: :user_certs

end
