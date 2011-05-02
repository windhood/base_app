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
  
  ################### Private functions ############################
  private
  def new_wowo_with_guid
    @wowo = Wowo.new
    @wowo.set_guid
  end
end