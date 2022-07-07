# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.where(email: 'test1@test.com', first_name: 'Adam',
                           last_name: 'Tester').first_or_create!(password: 'password')
employee2 = Employee.where(email: 'mscott@dm.com', first_name: 'Michael',
                           last_name: 'Scott').first_or_create!(password: 'password')
employee3 = Employee.where(email: 'dschrute@dm.com', first_name: 'Dwight',
                           last_name: 'Schrute').first_or_create!(password: 'password')
employee4 = Employee.where(email: 'jhalpert@dm.com', first_name: 'Jim',
                           last_name: 'Halpert').first_or_create!(password: 'password')
employee5 = Employee.where(email: 'pbeesly@dm.com', first_name: 'Pam',
                           last_name: 'Beesly').first_or_create!(password: 'password')
employee6 = Employee.where(email: 'cbratton@dm.com', first_name: 'Creed',
                           last_name: 'Bratton').first_or_create!(password: 'password')

AdminUser.where(email: 'admin@admin.com').first_or_create!(password: 'password')

cv1 = CompanyValue.create!(title: 'Patient')
cv2 = CompanyValue.create!(title: 'Helpful')

Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee1.id, receiver_id: employee6.id,
             company_value: cv1)
Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee2.id, receiver_id: employee5.id,
             company_value: cv2)
Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee3.id, receiver_id: employee4.id,
             company_value: cv1)
Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee4.id, receiver_id: employee3.id,
             company_value: cv2)
Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee5.id, receiver_id: employee2.id,
             company_value: cv1)
Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, giver_id: employee6.id, receiver_id: employee1.id,
             company_value: cv2)

5.times do |x|
  Reward.where(title: t = Faker::Commerce.product_name).first_or_create!(slug: t.parameterize,
                                                                         description: Faker::GreekPhilosophers.quote,
                                                                         price: x + 1)
end

5.times do
  Category.where(title: Faker::Team.creature).first_or_create!
end
