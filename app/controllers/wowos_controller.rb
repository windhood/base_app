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
    #@comment = Comment.create!(params[:comment])
    @wowo = Wowo.create(params[:wowo])
    flash[:notice] = "Publish successful!"
    respond_to do |format|
      format.html { redirect_to wowos_path }
      format.js
    end
    
  end
  
  ################### Private functions ############################
  private
  def new_wowo_with_guid
    @wowo = Wowo.new
    @wowo.set_guid
  end
end