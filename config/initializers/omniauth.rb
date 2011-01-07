Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, SERVICES['twitter']['consumer_key'], SERVICES['twitter']['consumer_secret']
  provider :facebook, SERVICES['facebook']['app_id'], SERVICES['facebook']['app_secret'], :scope => "publish_stream,email,offline_access"
end