# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@client_1 = Client.create(first_name: 'Fede',last_name: 'Gratti',address: '3 y 65 1328',telephone: 12345678,ci: '23345567')

@car_1 = Car.create(client_id: @client_1.id,brand: 'Ford',model: 'Mustang', chassis_number: 'gp2312389yhd', engine_number: 'asd13123ads', plate: '123asd23', kilometers: '9999990', sell_date: Date.new)

@repair_order_1 =   Repair.create(car_id: @car_1.id, order_number: 88988,description: 'this is a repair',ajax: false)
@repair_order_2 = Campaign.create(car_id: @car_1.id, order_number: 88989,description: 'this is a campaign',ajax: true,claim_number:1234,operation_number:'aa22dd33')

@technical_report_1 = TechnicalReport.create(car_id: @car_1.id,picture:'http://cloudtag.io/pic01.jpg')

@manual_1 = Manual.create(car_id: @car_1.id,operation_number:'asd_123')
