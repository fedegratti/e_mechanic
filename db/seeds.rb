@no_country = Country.create(name: 'Desconocido')
@no_state = State.create(country_id: @no_country.id, name: 'Desconocido')
@no_city = City.create(state_id: @no_state.id, name: 'Desconocido')

@country_1 = Country.create(name: 'Uruguay')
@state_1 = State.create(country_id: @country_1.id, name: 'Colonia')
@city_1 = City.create(state_id: @state_1.id, name: 'Carmelo')

@mechanic_1 = Mechanic.create(city_id: @city_1.id, first_name: 'Guillermo', last_name: 'test', address: 'a street', email:'guille@test.com', telephone: 12345678, identification: '1231231')

@no_client = Client.create(city_id: @no_city.id, first_name: 'Desconocido',last_name: 'Desconocido',address: '', email:'',telephone: 0,identification: '0',client_type: 'Person')
@client_1 = Client.create(city_id: @city_1.id, first_name: 'Fede',last_name: 'Gratti',address: '3 y 65 1328', email:'fede@test.com',telephone: 12345678,identification: '23345567',client_type: 'Person')
@client_2 = Client.create(city_id: @city_1.id, first_name: 'Ta',last_name: 'ta',address: 'en la calle', email:'tata@test.com',telephone: 12345678,identification: 'asd2345',client_type: 'Company')

@car_1 = Car.create(client_id: @client_1.id,brand: 'Ford',model: 'Mustang', chassis_number: 'GP2312389YHD43D23', engine_number: 'asd13123ads', plate: '123asd23', sell_date: Time.now)

@repair_order_1 =   RepairOrder.create(car_id: @car_1.id,
                                  mechanic_id: @mechanic_1.id,
                                  order_number: 8898,
                                  description: 'this is a repair',
                                  note: 'change lights in the next service',
                                  ayax: false,
                                  kilometers: 350000,
                                  repair_date: Time.now,
                                  compliance_date: Time.now + (60 * 60 * 24),
                                  order_type: 'Repair')

@repair_order_2 = RepairOrder.create(car_id: @car_1.id,
                                  mechanic_id: @mechanic_1.id,
                                  order_number: 8899,
                                  description: 'this is a campaign',
                                  note: '',
                                  ayax: true,
                                  claim_number:1234,
                                  operation_number:'aa22dd33',
                                  kilometers: 20,
                                  repair_date: Time.now,
                                  compliance_date: Time.now + (60 * 60 * 24),
                                  order_type: 'Campaign')

@technical_report_1 = TechnicalReport.create(car_id: @car_1.id,picture:'http://cloudtag.io/pic01.jpg')

@manual_1 = Manual.create(car_id: @car_1.id,operation_number:'asd_123')
