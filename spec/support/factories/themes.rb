# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :theme do |f|
  f.name "Default Theme"
  f.url "/themes/default/"
  f.image "/themes/default/images/default.jpg"
end