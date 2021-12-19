# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.create! :email => 'test1@test.com', :password => '123456', :password_confirmation => '123456'
employee2 = Employee.create! :email => 'test2@test.com', :password => '123456', :password_confirmation => '123456'
employee3 = Employee.create! :email => 'test3@test.com', :password => '123456', :password_confirmation => '123456'
employee4 = Employee.create! :email => 'test4@test.com', :password => '123456', :password_confirmation => '123456'
employee5 = Employee.create! :email => 'test5@test.com', :password => '123456', :password_confirmation => '123456'

kudo1 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 1, :receiver_id => 3
kudo3 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 3, :receiver_id => 2
kudo1 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 2, :receiver_id => 4
kudo3 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 4, :receiver_id => 1
kudo3 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 5, :receiver_id => 5