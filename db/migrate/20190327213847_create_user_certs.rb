class CreateUserCerts < ActiveRecord::Migration
  def change
    create_table :user_certs do |t|
      t.integer :user_id
      t.integer :cert_id
    end
  end
end
