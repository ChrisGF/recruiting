class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
    	t.integer :deal_id
    	t.integer :user_id
    end
  end
end
