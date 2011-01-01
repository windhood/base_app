class PagesController < ApplicationController
  before_filter :set_landing_page
  
  def home    
  end

  def contact
  end
  
  def about
  end
private 
  def set_landing_page
    @landing_page = true
  end
end
