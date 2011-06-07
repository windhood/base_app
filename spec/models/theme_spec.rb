require 'spec_helper'

describe Theme do
  it "should create a new instance given valid attributes" do
    Factory(:theme)
  end
  
  context "validation" do    
    describe "of name" do
      it "requires name" do
        theme = Factory.build(:theme, :name => nil)
        theme.should_not be_valid
      end  
      it "requires uniqueness" do
        theme = Factory(:theme)
        duplicate_theme = Factory.build(:theme, :name => theme.name)
        duplicate_theme.should_not be_valid
      end  
      it "fails if the requested name is only different in case from an existing name" do
        theme = Factory(:theme)
        duplicate_theme = Factory.build(:theme, :name => theme.name.upcase)
        duplicate_theme.should_not be_valid
      end 
    end
    
    describe "of url" do
      it "requires url" do
        theme = Factory.build(:theme, :url => nil)
        theme.should_not be_valid
      end      
    end
    
    describe "of image" do
      it "requires image" do
        theme = Factory.build(:theme, :image => nil)
        theme.should_not be_valid
      end 
      
      it "allows duplicated image" do
        theme = Factory(:theme)
        duplicate = Factory.build(:theme, :name => 'another one')
        duplicate.should be_valid
      end     
    end
    
  end  
  
end
