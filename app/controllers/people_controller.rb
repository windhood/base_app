class PeopleController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @user  = current_user
  end
  
  def update
    params[:user] ||= {}
    params[:user][:searchable] ||= false
    
    if current_user.update_attributes params[:user]
      flash[:notice] = I18n.t 'people.update.updated'
    else
      flash[:error] = I18n.t 'people.update.failed'
    end
    
    if params[:getting_started]
      redirect_to getting_started_path(:step => params[:getting_started].to_i+1)
    else
      redirect_to edit_person_path
    end
  end
end