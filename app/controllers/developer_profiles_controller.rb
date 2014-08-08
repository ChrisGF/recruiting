class DeveloperProfilesController < InheritedResources::Base
  
  def next_steps  
  end

  def show
    user = User.find(params[:user_id])
    @developer_profile = user.developer_profile
  end

  def edit
  	@user = User.find(params[:user_id])
  	@developer_profile = @user.developer_profile
  end

  def update
  	user = User.find(params[:user_id])
  	@developer_profile = user.developer_profile
  	if @developer_profile.update(developer_profile_params)
  		redirect_to user_developer_profile_path, notice: "Profile updated!"
  	else
  		render :edit
  	end
  end

private

  def developer_profile_params
  	params.require(:developer_profile).permit(:name, :employment, :experience, :yearly_projects,
  	               :typical_project_size, :how_did_you_hear, :how_response, :why, :state)
  end

end
