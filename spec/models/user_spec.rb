require 'spec_helper'

describe User do
  it "should create a new instance given valid attributes" do
    make_user
  end
  
  context "validation" do    
    describe "of email" do
      it "requires an email address" do
        user = Factory.build(:user, :email => nil)
        user.should_not be_valid
      end
      it "requires a unique email address" do
        duplicate_user = Factory.build(:user, :email => make_user.email)
        duplicate_user.should_not be_valid
      end
      it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = Factory.build(:user, :email => address)
          valid_email_user.should be_valid
        end
      end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = Factory.build(:user, :email => address)
          invalid_email_user.should_not be_valid
        end
      end
    end
    
    describe "of username" do
      it "requires presence" do
        user = Factory.build(:user, :username => nil)
        user.should_not be_valid
      end
      it "requires uniqueness" do
        duplicate_user = Factory.build(:user, :username => make_user.username)
        duplicate_user.should_not be_valid
      end

      it "downcases username" do
        user = Factory.build(:user, :username => "WeIrDcAsE")
        user.should be_valid
        user.username.should == "weirdcase"
      end

      it "fails if the requested username is only different in case from an existing username" do
        duplicate_user = Factory.build(:user, :username => make_user.username.upcase)
        duplicate_user.should_not be_valid
      end

      it "strips leading and trailing whitespace" do
        user = Factory.build(:user, :username => "    janie    ")
        user.should be_valid
        user.username.should == "janie"
      end

      it "fails if there's whitespace in the middle" do
        user = Factory.build(:user, :username => "bobby tables")
        user.should_not be_valid
      end

      it 'can not contain non url safe characters' do
        user = Factory.build(:user, :username => "kittens;")
        user.should_not be_valid
      end

      it 'should not contain periods' do
        user = Factory.build(:user, :username => "kittens.")
        user.should_not be_valid
      end

      it "can be 50 characters long" do
        user = Factory.build(:user, :username => "a" * 50)
        user.should be_valid
      end

      it "cannot be 51 characters" do
        user = Factory.build(:user, :username => "a" * 51)
        user.should_not be_valid
      end
    end
    
    describe "of passwords" do
      it "fails if password doesn't match confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "nope")
        user.should_not be_valid
      end

      it "succeeds if password matches confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "password")
        user.should be_valid
      end
    end
    
    describe "of name" do
      it "can be 100 characters long" do
        user = Factory.build(:user, :name => "a" * 100)
        user.should be_valid
      end

      it "cannot be 101 characters" do
        user = Factory.build(:user, :name => "a" * 101)
        user.should_not be_valid
      end
      
      it "strips leading and trailing whitespace" do
        user = Factory.build(:user, :name => "     Shelly    ")
        user.should be_valid
        user.name.should == "Shelly"
      end
    end
    
  end
end
