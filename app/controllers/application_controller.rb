class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource    
  
  class AccessDenied < StandardError; end 
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from AccessDenied, :with => :access_denied
    rescue_from NoMethodError, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,        :with => :render_not_found
    rescue_from ActionController::RoutingError,      :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction,     :with => :render_not_found
    rescue_from Exception,                           :with => :render_error
  end  
  
  before_filter :set_locale
  #around_filter :catch_errors
  
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
 
  def access_denied
    respond_to do |format|
      format.html { 
        flash.now[:error] = exception.message
        #render :text => '', :layout => !request.xhr?, :status => 500
        render :template => "/error_pages/422.html.haml",
                :status => 422,
                :layout => 'error.html.haml'
      }
      format.atom { head 422 }
      format.xml { head 422 }
      format.json { head 422 }
    end
  end
  
  def render_not_found(exception)    
    Rails.logger.error "Exception #{exception.class}: #{exception.message}"
    Rails.logger.error(exception.backtrace.join("\n"))
    respond_to do |format|
      format.html { 
        flash.now[:error] = exception.message
        #render :text => '', :layout => !request.xhr?, :status => 500
        render :template => "/error_pages/404.html.haml",
                :status => 404,
                :layout => 'error.html.haml'
      }
      format.atom { head 404 }
      format.xml { head 404 }
      format.json { head 404 }
    end
  end
  
  def render_error(exception)
    log_stack_trace exception
    respond_to do |format|
      format.html { 
        flash.now[:error] = exception.message
        #render :text => '', :layout => !request.xhr?, :status => 500
        render :template => "/error_pages/500.html.haml",
               :status => 500,
               :layout => 'error.html.haml'
      }
      format.atom { head 500 }
      format.xml { head 500 }
      format.json { head 500 }
    end
  end
  def log_stack_trace(exception)
    Rails.logger.error "Exception #{exception.class}: #{exception.message}"
    Rails.logger.error(exception.backtrace.join("\n"))
  end
  def catch_errors
    begin
      yield
    rescue AccessDenied=>ae
      flash[:notice] = "You do not have access to that area.".t
      handle_error(ae)        
    rescue ActiveRecord::RecordNotFound=>e
      flash[:notice] = "Sorry, can't find that record.".t
      handle_error(e)
    end
  end
  def handle_error(e) 
    logger.info "ApplicationControllter#catch_errors: #{e}"
    respond_to do |format|
      format.html { redirect_back_or_default('/') }
      format.xml  { render :text => "error" }
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
