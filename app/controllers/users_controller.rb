class UsersController  < ApplicationController
  before_filter :authenticate_user!
  respond_to :html
  
  def getting_started
    @user = current_user
    @services = @user.services
    @step = ((params[:step].to_i>0)&&(params[:step].to_i<5)) ? params[:step].to_i : 1
    @step ||= 1

    if @step == 4
      @user.getting_started = false
      @user.save
    end
    render "users/getting_started"
  end
  
  def getting_started_completed
    user = current_user
    user.update_attributes( :getting_started => false )
    redirect_to user_root_path
  end
  
  def my_dashboard
    if current_user.getting_started == true
      redirect_to getting_started_path
    end
  end
  
  def update
    @user = current_user

    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    params[:user].delete(:language) if params[:user][:language].blank?

    # change email notifications
    if params[:user][:disable_mail]
      @user.update_attributes(:disable_mail => params[:user][:disable_mail])
      flash[:notice] = I18n.t 'users.update.email_notifications_changed'
    # change passowrd
    elsif params[:user][:password] && params[:user][:password_confirmation]
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        flash[:notice] = I18n.t 'users.update.password_changed'
      else
        flash[:error] = I18n.t 'users.update.password_not_changed'
      end
    #elsif params[:user][:language]
    #  if @user.update_attributes(:language => params[:user][:language])
    #    flash[:notice] = I18n.t 'users.update.language_changed'
    #  else
    #    flash[:error] = I18n.t 'users.update.language_not_changed'
    #  end
    end

    redirect_to edit_user_path(@user)
  end
  
  def edit
    @user = current_user
  end
end