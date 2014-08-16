class DeveloperProfilesController < InheritedResources::Base
  
  def next_steps
    
  end
  
  def index
    if current_user.developer_profile.present?
      @developer_profile = current_user.developer_profile
      render :edit
    else
      @developer_profile = DeveloperProfile.new
      render :new
    end
  end
  
  def create
    @developer_profile = DeveloperProfile.new(permitted_params.merge({user_id: current_user.id}))
    
    if @developer_profile.valid?
      @developer_profile.save
      flash.now[:success] = "Your profile was created."
      render :edit
    else
      flash.now[:error] = "There was a problem."
      render :new
    end
  end
  
  def new
    @developer_profile = DeveloperProfile.new
    render :new
  end
  
  def show
    if current_user.developer_profile.id.to_s == params[:id].to_s
      @developer_profile = current_user.developer_profile
      render :edit
    else
      redirect_to :action => 'index'
    end
  end
  
  def update
    if current_user.developer_profile.id.to_s == params[:id].to_s
      @developer_profile = DeveloperProfile.new(permitted_params.merge({user_id: current_user.id }))
      @developer_profile.assign_attributes(permitted_params)
    
      if @developer_profile.valid?
        @developer_profile.save
        flash.now[:success] = "Your profile was updated."
        render :edit
      else
        flash.now[:error] = "There was a problem."
        render :edit
      end
    end
  end
  
  protected
    def permitted_params
      params.require(:developer_profile).permit!
    end
end
