class SecondaryCoursesController < ApplicationController
  before_action :set_secondary_course, only: [:show, :edit, :update, :destroy]

  # GET /secondary_courses
  # GET /secondary_courses.json
  def index
    @secondary_courses = SecondaryCourse.all
  end

  # GET /secondary_courses/1
  # GET /secondary_courses/1.json
  def show
  end

  # GET /secondary_courses/new
  def new
    @secondary_course = SecondaryCourse.new
  end

  # GET /secondary_courses/1/edit
  def edit
  end

  # POST /secondary_courses
  # POST /secondary_courses.json
  def create
    @secondary_course = SecondaryCourse.new(secondary_course_params)

    respond_to do |format|
      if @secondary_course.save
        format.html { redirect_to @secondary_course, notice: 'Secondary course was successfully created.' }
        format.json { render :show, status: :created, location: @secondary_course }
      else
        format.html { render :new }
        format.json { render json: @secondary_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secondary_courses/1
  # PATCH/PUT /secondary_courses/1.json
  def update
    respond_to do |format|
      if @secondary_course.update(secondary_course_params)
        format.html { redirect_to @secondary_course, notice: 'Secondary course was successfully updated.' }
        format.json { render :show, status: :ok, location: @secondary_course }
      else
        format.html { render :edit }
        format.json { render json: @secondary_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secondary_courses/1
  # DELETE /secondary_courses/1.json
  def destroy
    @secondary_course.destroy
    respond_to do |format|
      format.html { redirect_to secondary_courses_url, notice: 'Secondary course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secondary_course
      @secondary_course = SecondaryCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secondary_course_params
      params.require(:secondary_course).permit(:dept, :number, :section, :name, :description, :title, :designation, :course_details, :prerequisites, :units, :term, :delivery_method, :schedule)
    end
end
