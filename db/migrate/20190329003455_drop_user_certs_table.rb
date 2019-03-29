class DropUserCertsTable < ActiveRecord::Migration
  def change
    drop_table :user_certs
  end
end
