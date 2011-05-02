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
  
  has_one :theme
  belongs_to :user
  #validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  
  attr_accessible :name, :url, :theme, :published
end
