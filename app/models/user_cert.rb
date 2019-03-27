class UserCert < ActiveRecord::Base

  belongs_to :user
  belongs_to :cert

end
