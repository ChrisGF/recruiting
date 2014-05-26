ActiveAdmin.register Deal do
  
  permit_params :model

  filter :state
  filter :capital_type
  filter :close_timeline
  filter :amount_to_raise
  
  scope :all
  scope :published
  
  index do
    column(:name)
    column(:short_description)
    column(:state)
    column(:capital_type)
    column(:close_timeline)
    column(:amount_to_raise)
    column('Location') {|deal| [deal.address.state, deal.address.city].join(", ") }
  end
  
end
