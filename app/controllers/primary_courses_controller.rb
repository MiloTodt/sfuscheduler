class PrimaryCoursesController < ApplicationController
  before_action :set_primary_course, only: [:show, :edit, :update, :destroy]

  # GET /primary_courses
  # GET /primary_courses.json
  def index
    @primary_courses = PrimaryCourse.all
  end

  # GET /primary_courses/1
  # GET /primary_courses/1.json
  def show
  end

  # GET /primary_courses/new
  def new
    @primary_course = PrimaryCourse.new
  end

  # GET /primary_courses/1/edit
  def edit
  end

  # POST /primary_courses
  # POST /primary_courses.json
  def create
    @primary_course = PrimaryCourse.new(primary_course_params)

    respond_to do |format|
      if @primary_course.save
        format.html { redirect_to @primary_course, notice: 'Primary course was successfully created.' }
        format.json { render :show, status: :created, location: @primary_course }
      else
        format.html { render :new }
        format.json { render json: @primary_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /primary_courses/1
  # PATCH/PUT /primary_courses/1.json
  def update
    respond_to do |format|
      if @primary_course.update(primary_course_params)
        format.html { redirect_to @primary_course, notice: 'Primary course was successfully updated.' }
        format.json { render :show, status: :ok, location: @primary_course }
      else
        format.html { render :edit }
        format.json { render json: @primary_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_courses/1
  # DELETE /primary_courses/1.json
  def destroy
    @primary_course.destroy
    respond_to do |format|
      format.html { redirect_to primary_courses_url, notice: 'Primary course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_primary_course
      @primary_course = PrimaryCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def primary_course_params
      params.require(:primary_course).permit(:dept, :number, :section, :name, :description, :title, :designation, :course_details, :prerequisites, :units, :term, :instructor_name, :instructor_email, :short_note, :delivery_method, :schedule)
    end
end
