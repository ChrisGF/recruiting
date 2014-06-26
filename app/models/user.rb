class User < ActiveRecord::Base
  include Groundfloor::Addressable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
         :trackable, :validatable, :lockable, :timeoutable


  before_create :split_name

  has_many :deals, :dependent => :destroy
  has_many :user_deals
  has_many :followed_deals, through: :user_deals, source: :deal


  has_one :developer_profile, :dependent => :destroy
  accepts_nested_attributes_for :developer_profile
         
  # Nested Attributes Objects.. Automatically build if there is nothing there
  def address
    super || build_address
  end

  def split_name
   if self.name.present? 
     self.first_name = self.name.split(" ").first
     self.last_name = self.name.split(" ").last
   end
  end

end
