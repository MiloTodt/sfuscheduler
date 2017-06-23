class SchedulesBuildersController < ApplicationController
  before_action :set_schedules_builder, only: [:show, :edit, :update, :destroy]

  # GET /schedules_builders
  # GET /schedules_builders.json
  def index
    @schedules_builders = SchedulesBuilder.all
  end

  # GET /schedules_builders/1
  # GET /schedules_builders/1.json
  def show
  end

  # GET /schedules_builders/new
  def new
    @schedules_builder = SchedulesBuilder.new
  end

  # GET /schedules_builders/1/edit
  def edit
  end

  # POST /schedules_builders
  # POST /schedules_builders.json
  def create
    @schedules_builder = SchedulesBuilder.new(schedules_builder_params)

    respond_to do |format|
      if @schedules_builder.save
        format.html { redirect_to @schedules_builder, notice: 'Schedules builder was successfully created.' }
        format.json { render :show, status: :created, location: @schedules_builder }
      else
        format.html { render :new }
        format.json { render json: @schedules_builder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules_builders/1
  # PATCH/PUT /schedules_builders/1.json
  def update
    respond_to do |format|
      if @schedules_builder.update(schedules_builder_params)
        format.html { redirect_to @schedules_builder, notice: 'Schedules builder was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedules_builder }
      else
        format.html { render :edit }
        format.json { render json: @schedules_builder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules_builders/1
  # DELETE /schedules_builders/1.json
  def destroy
    @schedules_builder.destroy
    respond_to do |format|
      format.html { redirect_to schedules_builders_url, notice: 'Schedules builder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedules_builder
      @schedules_builder = SchedulesBuilder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedules_builder_params
      params[:schedules_builder]
    end
end
