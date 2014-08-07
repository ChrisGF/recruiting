class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def store_referer
    session[:external_referer] = request.referer if session[:external_referer].blank?
  end

  def after_sign_in_path_for(resource, reroute=nil)
    if (current_user)
      stored_location = stored_location_for(resource)

      return reroute if reroute.present?
      return stored_location if stored_location.present?
      #return developer_profile_path if resource.developer_profile.blank? || resource.developer_profile.started?
      return "/developers/next-steps" if resource.deals.length < 1
      return deals_path
    else
      return root_path
    end
  end

end
