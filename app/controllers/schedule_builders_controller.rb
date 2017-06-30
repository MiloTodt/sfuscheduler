class ScheduleBuildersController < ApplicationController
  before_action :set_schedule_builder, only: [:show, :edit, :update, :destroy]

  # GET /schedule_builders
  # GET /schedule_builders.json
  def index
    @schedule_builders = ScheduleBuilder.all
  end

  # GET /schedule_builders/1
  # GET /schedule_builders/1.json
  def show
  end

  # GET /schedule_builders/new
  def new
    @schedule_builder = ScheduleBuilder.new(schedule_builder_params)


    @classes = [params[:classes].split(",")]
    @classes.flatten!

    times = File.readlines('coursetimes.txt') #currently loading from a txt file instead of the database for ease of coding
    @matches = [] #database hits for supplied parameters. 
    @classes.each do |course|
      @matches += times.select { |name| name[/#{course}/i] }
    end
    @names = Array.new()
    @times = Array.new()

    @matches.each do |entry| #builds name array, done this way to check for multiple entries.
      entry.slice!("\n") #removes new line
      entry = entry.split("%") #trims the name out
	    @names.push entry[0]
    end 

  @matches.each do |x| #builds the time array, regex black magic
    @times.push x[/\%(.*)/,1]
   end

    #there's a one to one coorespondance between the arrays
    #@names[1] will map to @times[1] so you can itterate through both and have them match.


    #course names+number regex [A-Z]\w{3,}[ ][0-9]{3}
  end


  # GET /schedule_builders/1/edit
  def edit
  end

  # POST /schedule_builders
  # POST /schedule_builders.json
  def create
    @schedule_builder = ScheduleBuilder.new(schedule_builder_params)

    respond_to do |format|
      if @schedule_builder.save
        format.html { redirect_to @schedule_builder, notice: 'Schedule builder was successfully created.' }
        format.json { render :show, status: :created, location: @schedule_builder }
      else
        format.html { render :new }
        format.json { render json: @schedule_builder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedule_builders/1
  # PATCH/PUT /schedule_builders/1.json
  def update
    respond_to do |format|
      if @schedule_builder.update(schedule_builder_params)
        format.html { redirect_to @schedule_builder, notice: 'Schedule builder was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule_builder }
      else
        format.html { render :edit }
        format.json { render json: @schedule_builder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule_builders/1
  # DELETE /schedule_builders/1.json
  def destroy
    @schedule_builder.destroy
    respond_to do |format|
      format.html { redirect_to schedule_builders_url, notice: 'Schedule builder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_builder
      @schedule_builder = ScheduleBuilder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_builder_params
      params.fetch(:schedule_builder, {})
    end
end
