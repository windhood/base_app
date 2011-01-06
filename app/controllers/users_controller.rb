class UsersController  < ApplicationController
  before_filter :authenticate_user!
  respond_to :html
  
  def getting_started
    @user = current_user
    @step = ((params[:step].to_i>0)&&(params[:step].to_i<5)) ? params[:step].to_i : 1
    @step ||= 1

    if @step == 4
      @user.getting_started = false
      @user.save
    end
    render "users/getting_started"
  end
  
  def my_dashboard
    if current_user.getting_started == true
      redirect_to getting_started_path
    end
  end
  
  def update
    params[:user] ||= {}
    params[:user][:searchable] ||= false
    
    if current_user.update params[:user]
      flash[:notice] = I18n.t 'people.update.updated'
    else
      flash[:error] = I18n.t 'people.update.failed'
    end
    
    if params[:getting_started]
      redirect_to getting_started_path(:step => params[:getting_started].to_i+1)
    else
      redirect_to edit_user_path
    end
  end
end