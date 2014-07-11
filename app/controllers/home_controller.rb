class HomeController < ApplicationController
  def index
  end

  def next_steps
  end

  def investments
    @published_offers = Deal.where(:state => "published")
  end

  def developers
  end
end
