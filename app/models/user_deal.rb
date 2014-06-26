class UserDeal < ActiveRecord::Base
  belongs_to :user
  belongs_to :deal
  
  validate :not_owner
  
  def is_owner?
      self.deal.user_id == self.user_id    
  end
  
  # Validations
  
  def not_owner
     errors.add(:user_id, "User can not follow their own deal") if self.is_owner?
  end
  
end
