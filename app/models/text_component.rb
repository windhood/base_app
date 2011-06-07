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
end
