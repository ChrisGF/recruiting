module ApplicationHelper
  def us_states
    Address::STATES
  end
  
  def simple_pluralize count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

  def display_flash_messages(flash)
    return_data = ""
    return_data += success_message(flash[:notice]) if flash[:notice].present?
    return_data += success_message(flash[:success]) if flash[:success].present?
    return_data += warning_message(flash[:alert]) if flash[:alert].present?
    return_data += information_message(flash[:info]) if flash[:info].present?
    return_data += error_message(flash[:error], flash[:error_messages], flash[:pre_error_message]) if flash[:error].present?
    return raw(return_data)
  end
  
  def success_message(html)
    return raw("<div class='alert alert-success'>#{html}</div>") unless html.blank?
  end

  def warning_message(html)
    return raw("<div class='alert alert-error'>#{html}</div>") unless html.blank?
  end

  def information_message(html)
    return raw("<div class='alert alert-info'>#{html}</div>") unless html.blank?
  end

  def error_message(html, errors=nil, pre_error_message=nil)
    html += format_errors_hash(errors, pre_error_message) if errors
    return raw("<div class='alert alert-error bg-danger'>#{html}</div>") unless html.blank?
  end

  def format_errors_hash(errors=nil, pre_error_message=nil)
    error_list = '<ul class="error_list">'
    errors.each do |e, m|
      if (pre_error_message)
        error_list += "<li>#{pre_error_message} #{"#{e}".humanize.downcase unless e == "base"} #{m}</li>"
      else
        error_list += "<li>#{"#{e}".humanize unless e == "base"} #{m}</li>"
      end
    end
    error_list += '</ul>'
  end
  
  def days_ago(date=nil)
    (Date.today - date).to_i
  end

  CATEGORIES = ["Single Family", "Multifamily (2-4 units)", "Multifamily (5+ units)", "Land", "Retail", "Office Building", "Restaurant", "Lodging / Resort", "Other Property Type"]

  def no_footer
    content_for :no_footer, true
  end
  
  def no_header
    content_for :no_header, true
  end

  def disable_copywrite
    content_for :disable_copywrite, true
  end

  def set_body_style(padding)
    content_for :body_style, padding
  end

  def set_header_tab(tab)
    content_for :header_tab, tab
  end

  def set_header_state(state)
    content_for :header_state, state
  end

  def set_page_title(title)
    content_for :page_title, title
  end
  
  def set_meta_description(description)
    content_for :meta_description, description
  end

  def set_cookie_key_value(key, value)
    cookies[key] = value
  end
end
