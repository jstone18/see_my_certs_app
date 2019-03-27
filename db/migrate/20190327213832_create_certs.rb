class CreateCerts < ActiveRecord::Migration
  def change
    create_table :certs do |t|
      t.string :cert_name
      t.string :exp_date
    end
  end
end
