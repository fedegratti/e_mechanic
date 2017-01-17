class RepairOrdersController < ApplicationController
  before_action :set_repair_order, only: [:show, :edit, :update, :destroy]
  before_action :set_last_repair_order_id, only: [:new, :edit]
  before_action :set_mechanics, only: [:new, :edit]



  def import_from_ayax
    cookie = get_ayax_cookie

    # Get the xls file
    download = open("http://www.dat-ayax.com/armoArchExcel.php?pchassis=#{@chassis_number}",
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Encoding' => 'gzip, deflate, sdch',
      'Accept-Language' => 'en-US,en;q=0.8',
      'Connection' => 'keep-alive',
      'Cookie' => cookie,
      'Host' => 'www.dat-ayax.com',
      'Referer' => 'http://www.dat-ayax.com/Historialvehiculo.php?flujo=valchassis',
      'Upgrade-Insecure-Requests' => '1',
      'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'
    )
    IO.copy_stream(download, 'downloads/data.xls')

    xls = Roo::Excel.new("downloads/data.xls", format: :xls)

    # Create a Client with xls info
    @client = nil
    unless xls.sheet('Propietarios').first_column.nil?
      xls.sheet('Propietarios').each_with_index do |row, index|
        unless index == 0
          identification = row[0].to_i.to_s
          first_name = row[1].to_s
          last_name =  row[2].to_s
          address =  row[3].to_s
          city_name =  row[4].to_s
          telephone =  row[5].to_i
          email = row[6].to_s

          city = City.get_by_name city_name
          if city.nil? && !city_name.empty? then
            city = City.create(name: city_name, state: State.find(1))
          end

          @client = Client.get_by_identification identification
          if @client.nil? then
            @client = Client.create(city_id: city.id, first_name: first_name,last_name: last_name,address: address, email:email,telephone: telephone,identification: identification)
          end
        end
      end
    else
      @client = Client.first
    end

    # Create a Car with xls info
    @car = nil
    xls.sheet('Datos Vehiculo').each_with_index do |row, index|
      unless index == 0
        chassis_number = row[0].to_s
        brand =  row[2].to_s
        model =  row[4].to_s
        plate =  row[5].to_i
        engine_number = row[6].to_s
        sell_date = !row[7].nil? ? Date::strptime(row[7].to_s, '%d/%m/%Y') : ''

        @car = Car.get_by_chassis_number chassis_number
        if @car.nil? then
          @car = Car.create(client_id: @client.id,brand: brand,model: model, chassis_number: chassis_number, engine_number: engine_number, plate: plate, sell_date: sell_date)
        end
      end
    end

    # Create Repair Orders with xls info
    @repair_order = nil
    unless xls.sheet('Historial').first_column.nil?
      xls.sheet('Historial').each_with_index do |row, index|
        unless index == 0
          type = row[1].to_s
          create_date = !row[2].nil? ? Date::strptime(row[2].to_s, '%d/%m/%Y') : ''
          kilometers =  row[3].to_s
          description = row[5].to_s
          order_number = row[6].to_s
          note =  row[7].to_s
          repair_date =  !row[8].nil? ? Date::strptime(row[8].to_s, '%d/%m/%Y') : ''
          compliance_date = !row[9].nil? ? Date::strptime(row[9].to_s, '%d/%m/%Y') : ''
          mechanic_name = row[10].to_s

          mechanic = Mechanic.get_by_name mechanic_name
          if mechanic.nil? && !mechanic_name.empty? then
            mechanic = Mechanic.create(first_name: mechanic_name, city: City.find(1))
          end

          type_association = Hash.new
          type_association['Reclamo de Garantia'] = 'Warranty'
          type_association['Campaña'] = 'Campaign'
          type_association['Reparacion'] = 'Repair'
          type_association['Mantenimiento'] = 'Service'

          unless order_number.empty?
            @repair_order = RepairOrder.get_by_order_number order_number
            if @repair_order.nil? then
              @repair_order = RepairOrder.create(car_id: @car.id,
                                                 mechanic_id: mechanic.id,
                                                 order_number: order_number,
                                                 description: description,
                                                 note: note,
                                                 ayax: true,
                                                 kilometers: kilometers,
                                                 repair_date: repair_date,
                                                 compliance_date: compliance_date,
                                                 created_at: create_date,
                                                 type: type_association[type])
            end
          end
        end
      end
    end

    render json: []
  end

  # GET /repair_orders
  # GET /repair_orders.json
  def index
    #@repair_orders = RepairOrder.limit 10
    @repair_orders = RepairOrder.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /repair_orders/1
  # GET /repair_orders/1.json
  def show
  end

  # GET /repair_orders/new
  def new
    @repair_order = RepairOrder.new
  end

  # GET /repair_orders/1/edit
  def edit
  end

  # POST /repair_orders
  # POST /repair_orders.json
  def create
    @repair_order = RepairOrder.new(repair_order_params)

    respond_to do |format|
      if @repair_order.save
        format.html { redirect_to repair_order_path(@repair_order), notice: 'Repair order was successfully created.' }
        format.json { render :show, status: :created, location: @repair_order }
      else
        format.html { render :new }
        format.json { render json: @repair_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repair_orders/1
  # PATCH/PUT /repair_orders/1.json
  def update
    respond_to do |format|
      if @repair_order.update(repair_order_params)
        format.html { redirect_to repair_order_path(@repair_order), notice: 'Repair order was successfully updated.' }
        format.json { render :show, status: :ok, location: @repair_order }
      else
        format.html { render :edit }
        format.json { render json: @repair_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_orders/1
  # DELETE /repair_orders/1.json
  def destroy
    @repair_order.destroy
    respond_to do |format|
      format.html { redirect_to repair_orders_url, notice: 'Repair order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /get_repair_orders_by_chassis_number/1
  def get_by_chassis_number
    @repair_orders = RepairOrder.get_by_chassis_number params[:chassis_number]
    render :layout => false
  end

  # GET /get_repair_orders_by_client_identification/1
  def get_by_identification
    @repair_orders = RepairOrder.get_by_identification params[:identification]
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair_order
      @repair_order = RepairOrder.find(params[:id])
    end

    def set_cars
      @cars = Car.all
    end

    def set_last_repair_order_id
      @last_repair_order_id = RepairOrder.order(order_number: :desc).first.order_number
    end

    def set_mechanics
      @mechanics = Mechanic.all
    end

    def get_ayax_cookie
      @chassis_number = params[:chassis_number]

      # Request to get an ayax cookie session
      data = "usuario=#{ENV['ayax_user']}&password=#{ENV['ayax_pass']}&Ingresar=Ingresar"

      headers = {
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Encoding" => "zip, deflate",
        "Accept-Language" => "en-US,en;q=0.8",
        "Cache-Control" => "max-age=0",
        "Connection" => "keep-alive",
        "Content-Length" => "50",
        "Content-Type" => "application/x-www-form-urlencoded",
        "Host" => "www.dat-ayax.com",
        "Origin" => "http://www.dat-ayax.com",
        "Referer" => "http://www.dat-ayax.com/Login.php",
        "Upgrade-Insecure-Requests" => "1",
        "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36"
      }

      http = Net::HTTP.new('www.dat-ayax.com')
      path = '/validarlogin.php'

      res = http.post(path, data, headers)

      cookie = "PHPSESSID=d8058070427e5df403ae445c8d8d1812"
      cookie = res.get_fields('set-cookie')[0].split(';')[0] unless res.get_fields('set-cookie').nil?

      # Request to validate the chassis number
      data = "chassis=#{@chassis_number}&valchassis=Validar+Chassis&tbusqueda=0&strbuscar=&matricula=&garantiaext=&cventa2=&codmodelo2=+&nommodelo2=+&ciudadvta2=+&codmarca2=&nommarca2="

      headers = {
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Encoding" => "zip, deflate",
        "Accept-Language" => "en-US,en;q=0.8",
        "Cache-Control" => "max-age=0",
        "Connection" => "keep-alive",
        "Content-Length" => "169",
        "Content-Type" => "application/x-www-form-urlencoded",
        "Cookie" => cookie,
        "Host" => "www.dat-ayax.com",
        "Origin" => "http://www.dat-ayax.com",
        "Referer" => "http://www.dat-ayax.com/HistorialVehiculo.php",
        "Upgrade-Insecure-Requests" => "1",
        "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36"
      }

      http = Net::HTTP.new('www.dat-ayax.com')
      path = '/Historialvehiculo.php?flujo=valchassis'

      res = http.post(path, data, headers)

      puts cookie
      cookie
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repair_order_params
      params.require(:repair_order).permit(:car_id, :mechanic_id, :order_number, :description, :ayax, :claim_number, :operation_number, :type, :kilometers, :repair_date, :compliance_date, :note)
    end
end
