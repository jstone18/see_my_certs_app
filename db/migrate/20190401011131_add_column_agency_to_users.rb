class AddColumnAgencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_agency, :string
  end
end
