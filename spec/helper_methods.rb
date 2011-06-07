module HelperMethods
  # will actually create a user
  def make_user
    Factory(:user)
  end
  
  #just build the user object, won't store to db
  def build_user
    Factory.build(:user)
  end
  
  def make_wowo
    Factory(:wowo)
  end
  
  def clone_wowo(wowo)
    wowo1 = Wowo.new(:name => wowo.name, 
                      :url => wowo.url, 
                      :published => wowo.published?, 
                      :profile_enabled => wowo.profile_enabled?,
                      :comments_enabled => wowo.comments_enabled?)
    wowo1.guid = wowo.guid
    wowo1.user = wowo.user
    wowo1.theme = wowo.theme
    wowo1
  end
end

