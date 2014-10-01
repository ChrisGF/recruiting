class User < ActiveRecord::Base
  include Groundfloor::Addressable
  acts_as_follower

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :lockable, :timeoutable


  before_create :split_name

  has_many :deals, :dependent => :destroy

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
