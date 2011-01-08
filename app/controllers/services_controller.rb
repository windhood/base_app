class ServicesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @services = current_user.services
  end

  def create
    auth = request.env['omniauth.auth']

    token = auth['credentials']['token']
    secret = auth['credentials']['secret']

    provider = auth['provider']
    user     = auth['user_info']

    service = "Services::#{provider.camelize}".constantize.new(:nickname => user['nickname'],
                                                               :access_token => token, 
                                                               :access_secret => secret,
                                                               :provider => provider,
                                                               :uid => auth['uid'])
    current_user.services << service

    flash[:notice] = I18n.t 'services.create.success'
    if current_user.getting_started
      redirect_to  getting_started_path(:step => 3)
    else
      redirect_to services_url 
    end
  end


  def failure
    Rails.logger.info  "error in oauth #{params.inspect}"
    flash[:error] = t('services.failure.error')
    redirect_to services_url
  end

  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy
    flash[:notice] = I18n.t 'services.destroy.success'
    redirect_to services_url
  end
end