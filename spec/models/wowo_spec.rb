require 'spec_helper'

describe Wowo do
  it "should create a new instance given valid attributes" do
    wowo = make_wowo
    wowo.should_not be_new_record
    wowo.guid.should_not be_nil
    wowo.theme.should_not be_new_record
  end
  
  context "validation" do    
    describe "of name" do
      it "requires name" do
        wowo = Factory.build(:wowo, :name => nil)
        wowo.should_not be_valid
      end 
      it "allows duplicate name" do
        wowo = Factory(:wowo)
        duplicate_wowo = clone_wowo(wowo)
        duplicate_wowo.guid = nil
        duplicate_wowo.url = 'my another url'
        duplicate_wowo.save
        duplicate_wowo.should be_valid
      end               
    end
    
    describe "of theme" do
      it "requires theme" do
        wowo = Factory.build(:wowo, :theme => nil)
        wowo.should_not be_valid
      end      
    end
    
    describe "of user" do
      it "requires user" do
        wowo = Factory.build(:wowo, :user => nil)
        wowo.should_not be_valid
      end      
    end
    
    describe "of guid" do
      it "will generate a guid after saving and the guid must be 24 characters" do
        wowo = Factory.build(:wowo, :guid => nil)
        wowo.should be_valid
        wowo.guid.should_not be_nil
        wowo.guid.size.should == 24
      end 
      it "requires uniqueness" do
        wowo = Factory(:wowo)
        duplicate_wowo = clone_wowo(wowo)
        duplicate_wowo.url = 'my another url'
        duplicate_wowo.save
        duplicate_wowo.should_not be_valid
      end         
    end
    
    describe "of url" do
      it "will have a url same as guid after creating if not set a url" do
        wowo = Factory.build(:wowo, :url => nil)
        wowo.url.should == wowo.guid
      end
      it "won't be same as guid if the url is set" do
        wowo = Factory.build(:wowo)
        wowo.url.should_not == wowo.guid
      end
      it "requires uniqueness" do
        wowo = Factory(:wowo)
        duplicate = clone_wowo(wowo)
        duplicate.guid = nil
        duplicate.save
        duplicate.should_not be_valid
      end
    end
    
    
  end
  
end