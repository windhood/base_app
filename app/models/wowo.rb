# == Schema Information
# Schema version: 20110502210436
#
# Table name: wowos
#
#  id         :integer         not null, primary key
#  name       :string(256)     not null
#  url        :string(128)     not null
#  guid       :string(128)     not null
#  theme_id   :integer
#  user_id    :integer
#  published  :boolean         not null
#  created_at :datetime
#  updated_at :datetime
#

class Wowo < ActiveRecord::Base
  include Wowo::Guid  
  before_validation(:on => :create) do
    make_data_complete
  end
  
  has_one :theme
  belongs_to :user
  has_many :components
  #validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  has_friendly_id :guid
  attr_accessible :name, :url, :theme_id, :published, :profile_enabled, :comments_enabled
  
private 
  def make_data_complete
    self.set_guid
    self.url = self.guid
    self.published = true    
  end
end
