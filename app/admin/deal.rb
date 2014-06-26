ActiveAdmin.register Deal do
    controller do
      def scoped_collection
        Deal.includes(:address)
      end
    end
  
  index do
    column :id
    column :capital_type
    column :amount_to_raise do |deal|
       deal.amount_to_raise.format
    end
    column :close_timeline
    column :name
    column :deal_state do |deal|
       deal.address.state
    end
    
 
  end
   
    # Create sections on the index screen
  scope :all, :default => true
  scope :published

  # Filterable attributes on the index screen
  filter :capital_type, as: :check_boxes, collection: lambda{ Deal::CAPITAL_TYPE }
  filter :close_timeline, as: :check_boxes, collection: lambda{ Deal::CLOSE_TIMELINE }
  filter :amount_to_raise
  filter :created_at 
end
