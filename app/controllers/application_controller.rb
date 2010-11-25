class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource    
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from NoMethodError, :with => :show_error
  before_filter :set_locale
  
private
  def layout_by_resource
    if devise_controller? && resource_name == :admin_user
      "active_admin"
    else
      "application"
    end
  end
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end
  def show_error(exception); render :text => exception.message; end
  
  def record_not_found
    Rails.logger.error "Exception #{exception.class}: #{exception.message}"
    Rails.logger.error(exception.backtrace.join("\n"))
    render_404
  end
  def render_403      
      respond_to do |format|
        format.html { render :template => "common/403", :layout => (request.xhr? ? false : 'base'), :status => 403 }
        format.atom { head 403 }
        format.xml { head 403 }
        format.json { head 403 }
      end
      return false
    end
    
    # please refer to redmine code
    def render_404
      respond_to do |format|
        format.html { render :template => "common/404", :layout => !request.xhr?, :status => 404 }
        format.atom { head 404 }
        format.xml { head 404 }
        format.json { head 404 }
      end
      return false
    end

    def render_error(msg)
      respond_to do |format|
        format.html { 
          flash.now[:error] = msg
          render :text => '', :layout => !request.xhr?, :status => 500
        }
        format.atom { head 500 }
        format.xml { head 500 }
        format.json { head 500 }
      end
    end

    def invalid_authenticity_token
      if api_request?
        logger.error "Form authenticity token is missing or is invalid. API calls must include a proper Content-type header (text/xml or text/json)."
      end
      render_error "Invalid form authenticity token."
    end

    def render_feed(items, options={})    
      @items = items || []
      @items.sort! {|x,y| y.event_datetime <=> x.event_datetime }
      @items = @items.slice(0, Setting.feeds_limit.to_i)
      @title = options[:title] || Setting.app_title
      render :template => "common/feed.atom.rxml", :layout => false, :content_type => 'application/atom+xml'
    end
end
