class Address < ActiveRecord::Base

  belongs_to :addressable, :polymorphic => true

  before_create :default_name

  #Could possibly move this to a config file or ENV var and be able to update without updating the app, but the point
  # was to try and define this in one place, and then base the STATES used for the form off of it. That way, a user
  # couldn't even select an invalid state, and we would just need to update VALID_STATES, and get STATES updated for
  # the form for free.
  VALID_STATES = ['GA']
  STATES = VALID_STATES.collect{|value| [value,value]}.sort

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
