class DealFollower < ActiveRecord::Base
  def self.follow(deal_id, user_id)
    # add follower
    DealFollower.create(deal_id:deal_id, user_id:user_id)
    
    # increment followers_count
    deal = Deal.find(deal_id)
    deal.followers_count += 1
    Deal.trigger_follow = true  # bypass before_save -> validate_project callback
    deal.save
  end
end
