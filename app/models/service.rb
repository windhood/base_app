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

class Service < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :user

  def public_message(post, length, url = "")
    url = "" if post.respond_to?(:photos) && post.photos.count == 0
    space_for_url = url.blank? ? 0 : (url.length + 1)
    truncated = truncate(post.message, :length => (length - space_for_url))
    truncated = "#{truncated} #{url}" unless url.blank?
    return truncated
  end
end
require File.join(Rails.root, 'app/models/services/facebook')
require File.join(Rails.root, 'app/models/services/twitter')
