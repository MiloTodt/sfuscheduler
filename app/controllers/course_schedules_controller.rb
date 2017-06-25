class CourseSchedulesController < ApplicationController
  before_action :set_course_schedule, only: [:show, :edit, :update, :destroy]

  # GET /course_schedules
  # GET /course_schedules.json
  def index
    @course_schedules = CourseSchedule.all
  end

  # GET /course_schedules/1
  # GET /course_schedules/1.json
  def show
  end

  # GET /course_schedules/new
  def new
    @course_schedule = CourseSchedule.new
  end

  # GET /course_schedules/1/edit
  def edit
  end

  # POST /course_schedules
  # POST /course_schedules.json
  def create
    @course_schedule = CourseSchedule.new(course_schedule_params)

    respond_to do |format|
      if @course_schedule.save
        format.html { redirect_to @course_schedule, notice: 'Course schedule was successfully created.' }
        format.json { render :show, status: :created, location: @course_schedule }
      else
        format.html { render :new }
        format.json { render json: @course_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_schedules/1
  # PATCH/PUT /course_schedules/1.json
  def update
    respond_to do |format|
      if @course_schedule.update(course_schedule_params)
        format.html { redirect_to @course_schedule, notice: 'Course schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_schedule }
      else
        format.html { render :edit }
        format.json { render json: @course_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_schedules/1
  # DELETE /course_schedules/1.json
  def destroy
    @course_schedule.destroy
    respond_to do |format|
      format.html { redirect_to course_schedules_url, notice: 'Course schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_schedule
      @course_schedule = CourseSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_schedule_params
      params.require(:course_schedule).permit(:name)
    end
end
