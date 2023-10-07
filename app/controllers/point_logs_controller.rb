class PointLogsController < ApplicationController
  before_action :set_point_log, only: %i[ show edit update destroy ]

  # GET /point_logs or /point_logs.json
  def index
    @point_logs = PointLog.all
  end

  # GET /point_logs/1 or /point_logs/1.json
  def show
  end

  # GET /point_logs/new
  def new
    @point_log = PointLog.new
  end

  # GET /point_logs/1/edit
  def edit
  end

  # POST /point_logs or /point_logs.json
  def create
    @point_log = PointLog.new(point_log_params)

    respond_to do |format|
      if @point_log.save
        format.html { redirect_to point_log_url(@point_log), notice: "Point log was successfully created." }
        format.json { render :show, status: :created, location: @point_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @point_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /point_logs/1 or /point_logs/1.json
  def update
    respond_to do |format|
      if @point_log.update(point_log_params)
        format.html { redirect_to point_log_url(@point_log), notice: "Point log was successfully updated." }
        format.json { render :show, status: :ok, location: @point_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @point_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /point_logs/1 or /point_logs/1.json
  def destroy
    @point_log.destroy!

    respond_to do |format|
      format.html { redirect_to point_logs_url, notice: "Point log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_log
      @point_log = PointLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def point_log_params
      params.require(:point_log).permit(:value, :type, :reason)
    end
end
