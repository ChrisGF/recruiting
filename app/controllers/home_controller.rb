class HomeController < ApplicationController
  def index
  end

  def next_steps
  end

  def investments
    @published_offers = Deal.return_published
  end

  def developers
  end
end
