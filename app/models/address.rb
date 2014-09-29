class Address < ActiveRecord::Base

  belongs_to :addressable, :polymorphic => true

  before_create :default_name

  validates :state, presence: true
  validates :state, inclusion: {in: VALID_STATES, message: "%{value} is not a valid state. We currently only do business in the following states: #{VALID_STATES.to_sentence}"}

  def self.deals_by_state
    Address.where{addressable_type.eq("Deal")}.select("addressable_id, state").order("state")
  end

  def city_state
    [city, state].compact.join(', ')
  end

  def default_name
    self.name = "Primary" unless self.name
  end

end
