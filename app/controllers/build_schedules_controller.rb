
class BuildSchedulesController < ApplicationController
  before_action :set_build_schedule, only: [:show, :edit, :update, :destroy]

  # GET /build_schedules
  # GET /build_schedules.json
  def index
    @build_schedules = BuildSchedule.all
  end

  # GET /build_schedules/1
  # GET /build_schedules/1.json
  def show
  end

  # GET /build_schedules/new
  def new
    @build_schedule = BuildSchedule.new
  end

  # GET /build_schedules/1/edit
  def edit
  end

  # POST /build_schedules
  # POST /build_schedules.json
  def create
    @build_schedule = BuildSchedule.new(build_schedule_params)

    respond_to do |format|
      if @build_schedule.save
        format.html { redirect_to @build_schedule, notice: 'Build schedule was successfully created.' }
        format.json { render :show, status: :created, location: @build_schedule }
      else
        format.html { render :new }
        format.json { render json: @build_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /build_schedules/1
  # PATCH/PUT /build_schedules/1.json
  def update
    respond_to do |format|
      if @build_schedule.update(build_schedule_params)
        format.html { redirect_to @build_schedule, notice: 'Build schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @build_schedule }
      else
        format.html { render :edit }
        format.json { render json: @build_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_schedules/1
  # DELETE /build_schedules/1.json
  def destroy
    @build_schedule.destroy
    respond_to do |format|
      format.html { redirect_to build_schedules_url, notice: 'Build schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build_schedule
      @build_schedule = BuildSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_schedule_params
      params.require(:build_schedule).permit(:courses)
    end
end
