# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.create! :email => 'test1@test.com', :password => '111111', :password_confirmation => '111111'
employee2 = Employee.create! :email => 'mscott@dm.com', :password => '111111', :password_confirmation => '111111'
employee3 = Employee.create! :email => 'dschrute@dm.com', :password => '111111', :password_confirmation => '111111'
employee4 = Employee.create! :email => 'jhalpert@dm.com', :password => '111111', :password_confirmation => '111111'
employee5 = Employee.create! :email => 'pbeesly@dm.com', :password => '111111', :password_confirmation => '111111'
employee6 = Employee.create! :email => 'cbratton@dm.com', :password => '111111', :password_confirmation => '111111'

kudo1 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 2, :receiver_id => 3
kudo2 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 3, :receiver_id => 2
kudo3 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 2, :receiver_id => 4
kudo4 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 4, :receiver_id => 6
kudo5 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 5, :receiver_id => 5
kudo6 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 6, :receiver_id => 2
kudo7 = Kudo.create! :title => Faker::Superhero.descriptor, :content => Faker::GreekPhilosophers.quote, :employee_id => 1, :receiver_id => 4