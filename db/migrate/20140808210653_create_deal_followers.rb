class CreateDealFollowers < ActiveRecord::Migration
  def change
    create_table :deal_followers do |t|
      t.integer :user_id
      t.integer :deal_id

      t.timestamps
    end
  end
end
