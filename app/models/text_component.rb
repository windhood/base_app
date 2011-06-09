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

class TextComponent < Component
  validate :attributes_not_allowed
  
  private
  
  def attributes_not_allowed
    errors.add(:uri, "can't have a uri") unless self.uri.blank?
    errors.add(:title, "can't have a titile") unless self.title.blank?
    if self.heading.blank? and self.content.blank?
      errors.add(:cotent, "can't be empty if heading is blank") 
    end
  end
end
