class WowosController  < ApplicationController
  def index
  end
  
  def new
    @themes = Theme.all
    new_wowo_with_guid #so that we could generate preview url
    unless @themes.blank?
      @wowo.theme = @themes[0]
    end
  end
  
  def preview
  end
  
  def create    
    @wowo = Wowo.new(params[:wowo])
    respond_to do |format| 
      if @wowo.save
        flash[:notice] = I18n.t 'wowos.create.wowo_created'
        format.html { redirect_to @wowo }
        format.js 
      else
        flash[:error] = I18n.t 'wowos.create.save_error'
        format.html { render :action => 'new' }
        format.js {render :create_error}
      end
    end
    rescue Exception => exc
      save_error exc
  end
  
  ################### Private functions ############################
  private
  def new_wowo_with_guid
    @wowo = Wowo.new
    @wowo.set_guid
  end
  def save_error(exception)
    log_stack_trace exception
    respond_to do |format| 
      format.js {render :create_error}
    end
  end
end