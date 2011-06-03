require 'spec_helper'

describe PagesController do
  #render_views #ideally we should test view in integration test or cucumber
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    #it "should have the right title" do
    #  visit "/about"  #ideally we should test view in integration test or cucumber
    #  page.should have_css("title", :text =>"About us") #ideally we should test view in integration test or cucumber
    #  #save_and_open_page
    #  #page.should have_content("About us")
    #end
  end
end
