module HelperMethods
  # will actually create a user
  def make_user
    Factory(:user)
  end
  
  #just build the user object, won't store to db
  def build_user
    Factory.build(:user)
  end
end
