# == Schema Information
# Schema version: 20110601232705
#
# Table name: wowos
#
#  id               :integer         not null, primary key
#  name             :string(256)     not null
#  url              :string(128)     not null
#  guid             :string(128)     not null
#  theme_id         :integer
#  user_id          :integer
#  published        :boolean         not null
#  created_at       :datetime
#  updated_at       :datetime
#  profile_enabled  :boolean         default(TRUE)
#  comments_enabled :boolean         default(TRUE)
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
  validates :name, :presence => true
  validates :theme, :presence => true
  validates :user, :presence => true
  validates :guid, :uniqueness => true
  validates :url, :uniqueness => true
  has_friendly_id :guid
  attr_accessible :name, :url, :theme_id, :published, :profile_enabled, :comments_enabled
  
  #virtual attributes getter
  def components_attributes
    
  end
  # Setter  
  def components_attributes=(attrs)  
    if attrs.blank?
      self.components = nil and return
    end
    self.components = []
    attrs.each do |c|
      self.components << build_component(c)
    end
    puts "OK"
    puts self.components
  end
  
  private 
  def make_data_complete
    self.set_guid
    self.url = self.guid if self.url.blank?
    self.published = true    
  end
  
  def build_component(c)
    class_name = c[:class_name]
    unless class_name.blank? 
      c.delete :class_name      
      if defined? class_name.camelize.constantize
        self.components << class_name.camelize.constantize.new(c)
      end
    end
  end
end
