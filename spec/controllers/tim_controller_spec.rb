require 'spec_helper'

describe TimController do

  describe "GET 'defects'" do
    it "returns http success" do
      get 'defects'
      response.should be_success
    end
  end

  describe "GET 'features'" do
    it "returns http success" do
      get 'features'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
