# == Schema Information
# Schema version: 20110502210436
#
# Table name: services
#
#  id            :integer         not null, primary key
#  type          :string(255)
#  user_id       :integer
#  provider      :string(255)
#  uid           :string(255)
#  access_token  :string(255)
#  access_secret :string(255)
#  nickname      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Services::Facebook < Service
  MAX_CHARACTERS = 420

  def post(post, url='')
    Rails.logger.debug("event=post_to_service type=facebook sender_id=#{self.user_id}")
    message = public_message(post, url)
    begin
      RestClient.post("https://graph.facebook.com/me/feed", :message => message, :access_token => self.access_token) 
    rescue Exception => e
      Rails.logger.info("#{e.message} failed to post to facebook")
    end
  end

  def public_message(post, url)
    super(post, MAX_CHARACTERS,  url)
  end
end
