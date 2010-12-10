# == Schema Information
# Schema version: 20101204003047
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  username             :string(255)     not null
#  bio                  :text
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  getting_started      :
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_validation :strip_names
  validates_length_of :name, :maximum => 100

  before_save :strip_names
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :bio,
    :image_url, :image_url_medium, :image_url_small
  
  def image_url(size = :thumb_large)
    if size == :thumb_medium
      self[:image_url_medium]
    elsif size == :thumb_small
      self[:image_url_small]
    else
      self[:image_url]
    end
  end


  def image_url= url
    return image_url if url == ''
    if url.nil? || url.match(/^https?:\/\//)
      super(url)
    else
      super(absolutify_local_url(url))
    end
  end

  def image_url_small= url
    return image_url if url == ''
    if url.nil? || url.match(/^https?:\/\//)
      super(url)
    else
      super(absolutify_local_url(url))
    end
  end

  def image_url_medium= url
    return image_url if url == ''
    if url.nil? || url.match(/^https?:\/\//)
      super(url)
    else
      super(absolutify_local_url(url))
    end
  end

  def date= params
    if ['year', 'month', 'day'].all? { |key| params[key].present? }
      date = Date.new(params['year'].to_i, params['month'].to_i, params['day'].to_i)
      self.birthday = date
    elsif ['year', 'month', 'day'].all? { |key| params[key] == '' }
      self.birthday = nil
    end
  end

  def display_name
    if name.blank?
      username
    else
      name
    end
  end
  protected

  def strip_names
    self.name.strip! if self.name
  end
  
end
