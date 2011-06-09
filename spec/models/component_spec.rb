require 'spec_helper'

describe Component do
  context "save components" do   
    before(:each) do
      @attr = { :heading => "heading-test", :content => "content-test", :uri => "uri-test", :title => "title-test" }
    end
    
    it "should create a new text component instance given valid attributes" do
      TextComponent.create!(@attr.merge(:uri => "", :title => ""))
    end
    
    it "does not allow a text component to have a uri" do
      text = TextComponent.new(@attr.merge(:title => ""))
      text.save
      text.should_not be_valid
    end 
    
    it "does not allow a text component to have a title" do
      text = TextComponent.new(@attr.merge(:uri => ""))
      text.save
      text.should_not be_valid
    end
    
    it "does not allow TextComponent's content and heading both blank" do
      text = TextComponent.new(@attr.merge(:title => "", :uri => "", :heading => "", :content => ""))
      text.save
      text.should_not be_valid
    end
    
    it "should create a new link component instance given valid attributes" do
      LinkComponent.create!(@attr.merge(:heading => "", :content => ""))
    end
    
    it "does not allow a link component to have a heading" do
      link = LinkComponent.new(@attr.merge(:content => ""))
      link.save
      link.should_not be_valid
    end 
    
    it "does not allow a link component to have a content" do
      link = LinkComponent.new(@attr.merge(:heading => ""))
      link.save
      link.should_not be_valid
    end
    
    it "requires a LinkComponent's uri to present" do
      link = LinkComponent.new(@attr.merge(:uri => "", :heading => "", :content => ""))
      link.save
      link.should_not be_valid
    end
    
  end
  
  
end
