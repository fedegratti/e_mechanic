class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :set_clients, only: [:new, :edit]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /get_car_by_chassis_number/1
  def get_by_chassis_number
    @car = Car.where("chassis_number = ?", "#{params[:chassis_number]}")
    render json: @car
  end

  # GET /get_car_by_client_identification/1
  def get_by_client_identification
    @client = Client.where("identification = ?", "#{params[:identification]}").first

    @car = 'not found'
    @car = @client.cars unless @client.nil?

    render json: @car
  end


  # GET /get_chassis_numbers/1
  def get_chassis_numbers
    @chassis_numbers = Car.order(:chassis_number).where("chassis_number ilike ?", "%#{params[:term]}%")
    render json: @chassis_numbers.map(&:chassis_number)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_clients
      @clients = Client.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:client_id, :brand, :model, :chassis_number, :engine_number, :plate, :kilometers, :sell_date)
    end
end
