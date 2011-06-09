# == Schema Information
# Schema version: 20110601232705
#
# Table name: components
#
#  id         :integer         not null, primary key
#  heading    :string(255)
#  content    :text
#  uri        :string(255)
#  title      :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LinkComponent < Component
  validates_presence_of :uri
  
  validate :attributes_not_allowed
  
  private
  
  def attributes_not_allowed
    errors.add(:heading, "can't have a heading") unless self.heading.blank?
    errors.add(:content, "can't have a content") unless self.content.blank?
  end
end
