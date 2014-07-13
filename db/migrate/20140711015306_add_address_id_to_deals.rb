class AddAddressIdToDeals < ActiveRecord::Migration
  def change
  	add_column :deals, :address_id, :integer
  end
end
