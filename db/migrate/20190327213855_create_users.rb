class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :provider_level
      t.string :email
      t.string :username
      t.string :password_digest
    end
  end
end
