class MechanicsController < ApplicationController
  before_action :set_mechanic, only: [:show, :edit, :update, :destroy]

  # GET /mechanics
  # GET /mechanics.json
  def index
    @mechanics = Mechanic.all
  end

  # GET /mechanics/1
  # GET /mechanics/1.json
  def show
  end

  # GET /mechanics/new
  def new
    @mechanic = Mechanic.new
  end

  # GET /mechanics/1/edit
  def edit
  end

  # POST /mechanics
  # POST /mechanics.json
  def create
    @mechanic = Mechanic.new(mechanic_params)

    respond_to do |format|
      if @mechanic.save
        format.html { redirect_to @mechanic, notice: 'Mechanic was successfully created.' }
        format.json { render :show, status: :created, location: @mechanic }
      else
        format.html { render :new }
        format.json { render json: @mechanic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mechanics/1
  # PATCH/PUT /mechanics/1.json
  def update
    respond_to do |format|
      if @mechanic.update(mechanic_params)
        format.html { redirect_to @mechanic, notice: 'Mechanic was successfully updated.' }
        format.json { render :show, status: :ok, location: @mechanic }
      else
        format.html { render :edit }
        format.json { render json: @mechanic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mechanics/1
  # DELETE /mechanics/1.json
  def destroy
    @mechanic.destroy
    respond_to do |format|
      format.html { redirect_to mechanics_url, notice: 'Mechanic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mechanic
      @mechanic = Mechanic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mechanic_params
      params.require(:mechanic).permit(:city_id, :first_name, :last_name, :telephone, :address, :email, :identification)
    end
end
