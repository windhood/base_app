# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :wowo do |f|
  f.name "test wowo name"
  f.url "http://www.wowo.com"
  #f.guid "0e1b6b80ccb308a76c4b6e34"  #should set by the callback
  f.published false
  f.association :theme
  f.association :user
end