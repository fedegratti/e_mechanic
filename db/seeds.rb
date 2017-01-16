# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@no_country = Country.create(name: 'Desconocido')
@no_state = State.create(country_id: @no_country.id, name: 'Desconocido')
@no_city = City.create(state_id: @no_state.id, name: 'Desconocido')

@country_1 = Country.create(name: 'Uruguay')
@state_1 = State.create(country_id: @country_1.id, name: 'Colonia')
@city_1 = City.create(state_id: @state_1.id, name: 'Carmelo')

@mechanic_1 = Mechanic.create(city_id: @city_1.id, first_name: 'Guillermo', last_name: 'test', address: 'a street', email:'guille@test.com', telephone: 12345678, identification: '1231231')

@client_1 = Person.create(city_id: @city_1.id, first_name: 'Fede',last_name: 'Gratti',address: '3 y 65 1328', email:'fede@test.com',telephone: 12345678,identification: '23345567')
@client_2 = Company.create(city_id: @city_1.id, first_name: 'Ta',last_name: 'ta',address: 'en la calle', email:'tata@test.com',telephone: 12345678,identification: 'asd2345')

@car_1 = Car.create(client_id: @client_1.id,brand: 'Ford',model: 'Mustang', chassis_number: 'gp2312389yhd', engine_number: 'asd13123ads', plate: '123asd23', sell_date: Time.now)

@repair_order_1 =   Repair.create(car_id: @car_1.id,
                                  mechanic_id: @mechanic_1.id,
                                  order_number: 88988,
                                  description: 'this is a repair',
                                  note: 'change lights in the next service',
                                  ajax: false,
                                  kilometers: 350000,
                                  repair_date: Time.now,
                                  compliance_date: Time.now + (60 * 60 * 24))

@repair_order_2 = Campaign.create(car_id: @car_1.id,
                                  mechanic_id: @mechanic_1.id,
                                  order_number: 88989,
                                  description: 'this is a campaign',
                                  note: '',
                                  ajax: true,
                                  claim_number:1234,
                                  operation_number:'aa22dd33',
                                  kilometers: 20,
                                  repair_date: Time.now,
                                  compliance_date: Time.now + (60 * 60 * 24))

@technical_report_1 = TechnicalReport.create(car_id: @car_1.id,picture:'http://cloudtag.io/pic01.jpg')

@manual_1 = Manual.create(car_id: @car_1.id,operation_number:'asd_123')
