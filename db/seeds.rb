# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

  User.create( :email => "chrisyuska@lithoslabs.com", :password => "password", :password_confirmation => "password", :admin => true, :name => "Chris Yuska" )

  ["Travel", "Software", "Legal", "Administrative", "Hardware"].each do |c|
    Category.find_or_create_by_name(c)
  end
