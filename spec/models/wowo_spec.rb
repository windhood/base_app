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
    
  end
  
end