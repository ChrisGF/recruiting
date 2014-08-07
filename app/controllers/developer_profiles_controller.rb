class DeveloperProfilesController < InheritedResources::Base
  
  def next_steps  
  end

  def show
    user = User.find(params[:id])
    @developer_profile = user.developer_profile
  end
end
