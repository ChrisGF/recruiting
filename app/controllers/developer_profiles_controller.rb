class DeveloperProfilesController < InheritedResources::Base
  
  before_filter :set_user
  before_filter :set_developer_profile

  def next_steps  
  end

  def show
  end

  def edit
  end

  def update
    if @developer_profile.update(developer_profile_params)
  		redirect_to user_developer_profile_path, notice: "Profile updated!"
  	else
  		render :edit
  	end
  end

private

  def set_user
  	@user = User.find(params[:user_id])
  end
  
  def set_developer_profile
  	@developer_profile = @user.developer_profile
  end

  def developer_profile_params
  	params.require(:developer_profile).permit(:name, :employment, :experience, :yearly_projects,
  	               :typical_project_size, :how_did_you_hear, :how_response, :why, :state)
  end


end
