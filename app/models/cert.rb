class Cert < ActiveRecord::Base

  has_many :user_certs
  has_many :users, through: :user_certs

end
