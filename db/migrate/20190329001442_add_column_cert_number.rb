class AddColumnCertNumber < ActiveRecord::Migration
  def change
    add_column :certs, :cert_number, :string
  end
end
