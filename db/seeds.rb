# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Theme.create(:name => 'Simple', :url =>'/themes/simple/style.css', :image => '/themes/simple/theme.jpg')
Theme.create(:name => 'Photo frame', :url =>'/themes/photo_frame/style.css', :image => '/themes/photo_frame/theme.jpg')
Theme.create(:name => 'Modern', :url =>'/themes/modern/style.css', :image => '/themes/modern/theme.jpg')
Theme.create(:name => 'letter', :url =>'/themes/letter/style.css', :image => '/themes/letter/theme.jpg')
Theme.create(:name => 'book', :url =>'/themes/book/style.css', :image => '/themes/book/theme.jpg')
Theme.create(:name => 'grey memory', :url =>'/themes/memory/style.css', :image => '/themes/grey_memory/theme.jpg')