class Address < ActiveRecord::Base

  belongs_to :addressable, :polymorphic => true

  before_create :default_name
  
  STATES=[['AK', 'AK'],['AL', 'AL'],['AR', 'AR'],['AZ', 'AZ'],['CA', 'CA'],['CO', 'CO'],['CT', 'CT'],['DC', 'DC'],['DE', 'DE'],['FL', 'FL'],
          ['GA', 'GA'],['HI', 'HI'],['IA', 'IA'],['ID', 'ID'],['IL', 'IL'],['IN', 'IN'],['KS', 'KS'],['KY', 'KY'],['LA', 'LA'],['MA', 'MA'],
          ['MD', 'MD'],['ME', 'ME'],['MI', 'MI'],['MN', 'MN'],['MO', 'MO'],['MS', 'MS'],['MT', 'MT'],['NC', 'NC'],['ND', 'ND'],['NE', 'NE'],
          ['NH', 'NH'],['NJ', 'NJ'],['NM', 'NM'],['NV', 'NV'],['NY', 'NY'],['OH', 'OH'],['OK', 'OK'],['OR', 'OR'],['PA', 'PA'],['RI', 'RI'],
          ['SC', 'SC'],['SD', 'SD'],['TN', 'TN'],['TX', 'TX'],['UT', 'UT'],['VA', 'VA'],['VT', 'VT'],['WA', 'WA'],['WI', 'WI'],['WV', 'WV'],
          ['WY', 'WY']
         ]
  
  validates :state, presence: true
  
  def self.deals_by_state
    Address.where{addressable_type.eq("Deal")}.select("addressable_id, state").order("state")
  end
  
  def city_state
    [city, state].compact.join(', ')
  end
  
  def default_name
    self.name = "Primary" unless self.name
  end

  # Only the states in this array will be available to the user when
  # creating a deal.
  #
  def self.available_states; 
    [['GA', 'GA']]
  end

end
