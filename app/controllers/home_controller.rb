class HomeController < ApplicationController
  def index
  end

  def next_steps
  end

  def investments
    @published_offers = Deal.return_published
  end
  
  def investments_follow
    DealFollower.follow(params[:deal_id], current_user.id)
    render nothing: true
  end

  def developers
  end
end
