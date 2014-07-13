class HomeController < ApplicationController
  def index
  end

  def next_steps
  end

  def investments
  	if params[:sort] == "price"
    	@published_offers = Deal.where(:state => "published").order("amount_to_raise_cents ASC")
    else
    	@published_offers = Deal.where(:state => "published").order("created_at DESC")
    end
  end

  def developers
  end
end
