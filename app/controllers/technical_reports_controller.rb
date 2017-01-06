class TechnicalReportsController < ApplicationController
  before_action :set_technical_report, only: [:show, :edit, :update, :destroy]

  # GET /technical_reports
  # GET /technical_reports.json
  def index
    @technical_reports = TechnicalReport.all
  end

  # GET /technical_reports/1
  # GET /technical_reports/1.json
  def show
  end

  # GET /technical_reports/new
  def new
    @technical_report = TechnicalReport.new
  end

  # GET /technical_reports/1/edit
  def edit
  end

  # POST /technical_reports
  # POST /technical_reports.json
  def create
    @technical_report = TechnicalReport.new(technical_report_params)

    respond_to do |format|
      if @technical_report.save
        format.html { redirect_to @technical_report, notice: 'Technical report was successfully created.' }
        format.json { render :show, status: :created, location: @technical_report }
      else
        format.html { render :new }
        format.json { render json: @technical_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technical_reports/1
  # PATCH/PUT /technical_reports/1.json
  def update
    respond_to do |format|
      if @technical_report.update(technical_report_params)
        format.html { redirect_to @technical_report, notice: 'Technical report was successfully updated.' }
        format.json { render :show, status: :ok, location: @technical_report }
      else
        format.html { render :edit }
        format.json { render json: @technical_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technical_reports/1
  # DELETE /technical_reports/1.json
  def destroy
    @technical_report.destroy
    respond_to do |format|
      format.html { redirect_to technical_reports_url, notice: 'Technical report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technical_report
      @technical_report = TechnicalReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technical_report_params
      params.require(:technical_report).permit(:picture)
    end
end
