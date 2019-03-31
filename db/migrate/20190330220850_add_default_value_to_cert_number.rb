class AddDefaultValueToCertNumber < ActiveRecord::Migration
  def change
    change_column :certs, :cert_number, :string, default: "n/a"
  end
end
