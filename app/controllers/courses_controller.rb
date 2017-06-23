class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Courses.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @courses = Courses.first
  end

  # GET /courses/new
  def new
    @courses = Courses.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    # render plain: params[:courses].inspect
    @courses = Courses.new(courses_params)

    respond_to do |format|
      if @courses.save
        format.html { redirect_to @courses, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @courses }
      else
        format.html { render :new }
        format.json { render json: @courses.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @courses.update(courses_params)
        format.html { redirect_to @courses, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @courses }
      else
        format.html { render :edit }
        format.json { render json: @courses.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Courses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def courses_params
      params.require(:courses).permit(:name, :times)
    end
end
