class Follower < ActiveRecord::Base
  belongs_to :user

  def self.exists?(deal_id, user_id)
  	f = Follower.where("deal_id = #{deal_id} and user_id = #{user_id}")
  	if f.blank?
  		return false
  	else
  		return true
  	end
  end

end