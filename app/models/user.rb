# == Schema Information
# Schema version: 20110105083930
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
#  getting_started      :boolean         default(TRUE)
#  image_url            :string(255)
#  image_url_medium     :string(255)
#  image_url_small      :string(255)
#  birthday             :date
#  gender               :string(255)
#  searchable           :boolean         default(TRUE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_validation :strip_and_downcase_username, :on => :create
  after_validation :strip_names
  
  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false
  validates_format_of :username, :with => /\A[A-Za-z0-9_]+\z/
  validates_length_of :username, :maximum => 50
  validates_length_of :name, :maximum => 100
  validates :email, :presence => true,
                    :format   => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  before_save :strip_names
  has_many :services
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :bio,:date,
    :image_url, :image_url_medium, :image_url_small, :getting_started, :birthday, :gender, :searchable
  
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
  
  def strip_and_downcase_username
    if username.present?
      username.strip!
      username.downcase!
    end
  end
  
end
