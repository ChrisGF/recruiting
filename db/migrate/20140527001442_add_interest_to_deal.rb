class AddInterestToDeal < ActiveRecord::Migration
  def up
    add_column :deals, :interest, :float
    
    # For demonstration purposes, all existing deals that have some form of debt component
    # will have an interest percentage between 5 and 10%. Equity-only deals will have 0%.
    Deal.find_each do |deal|
      deal.capital_type = ['Debt', 'Equity', 'Both', 'Flexible'].sample unless deal.capital_type
      deal.interest = deal.capital_type == 'Equity' ? 0.0 : ((5+ 5*rand)/100.0).round(4)
      deal.save!
    end
  end
  
  def down
    remove_column :deals, :interest, :decimal
  end
end
