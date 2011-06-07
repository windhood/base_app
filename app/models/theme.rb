# == Schema Information
# Schema version: 20110502210436
#
# Table name: themes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Theme < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :url, :presence => true
  validates :image, :presence => true
end
