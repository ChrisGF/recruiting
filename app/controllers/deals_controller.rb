class DealsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    @deals = current_user.deals.order(:name)
    return redirect_to "/developers/next-steps" if @deals.length < 1
  end
  
  def create
    @deal = Deal.new(permitted_params.merge({ user_id: current_user.id }))
    create! do |success, failure|
      success.html { 
        flash.now[:success] = "Your proposal was created."
        redirect_to deals_path
      }
      failure.html { 
        fixup_paperclip_errors
        flash.now[:error] = "Your project was not created. Please address the errors listed below and try again: <br><span>#{@deal.errors.full_messages.join('<br>')}</span>"
        render :new
      }
    end
  end

  def new
    @deal = Deal.new
  end

  def update
    @deal = current_user.deals.where(:id => params[:id]).first || Deal.new(permitted_params.merge({user_id: current_user.id }))

    @deal.assign_attributes(permitted_params)
    @deal.validate_project
    if @deal.save
      flash[:success] = "Your proposal was updated."
      redirect_to deals_path
    else
      fixup_paperclip_errors
      flash.now[:error] = "Your project was not updated. Please address the errors listed below and try again: <br><span>#{@deal.errors.full_messages.join('<br>')}</span>"
      render :edit
    end
  end
  
  def destroy
    destroy!(:info => "Your project was removed.") do |format|
      @deals = current_user.deals.order(:name)
      logger.debug("Deals: #{@deals.length}")

      if @deals.length < 1
        format.html { redirect_to "/developers/next-steps" }
      else
        format.html { redirect_to deals_path }
      end
    end
      
  end
  
  def publish
    flash[:notice]="Great News!  Your deal has been published to our website."
    @deal = current_user.deals.find(params[:deal_id])
    @deal.publish
    redirect_to deal_path(@deal)
  end

  def unpublish
    @deal = current_user.deals.find(params[:deal_id])
    @deal.unpublish
    flash[:notice] = "Your deal has successfully been unpublished and will no longer appear on the public website"
    redirect_to deals_path
  end
  
  protected
    def permitted_params
      params.require(:deal).permit!
    end
    
  private :permitted_params
  
end
