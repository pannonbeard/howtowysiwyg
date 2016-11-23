class DirectionsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_action :set_direction, only: [:show, :edit, :update, :destroy]

  # GET /directions
  # GET /directions.json
  def index
    if params[:scenario_id]
      @directions = Direction.where(scenario_id: params[:scenario_id])
      @scenario = Scenario.find(params[:scenario_id])
    else
      @directions = Direction.all
    end
  end

  # GET /directions/1
  # GET /directions/1.json
  def show
  end

  # GET /directions/new
  def new
    if params[:scenario_id]
      @direction = Direction.new
      @direction.scenario_id = params[:scenario_id]
    else
      @direction = Direction.new
    end
  end

  # GET /directions/1/edit
  def edit
  end

  # POST /directions
  # POST /directions.json
  def create
    @direction = Direction.new(direction_params)
    respond_to do |format|
      if @direction.save
        format.html { redirect_to @direction, notice: 'Direction was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /directions/1
  # PATCH/PUT /directions/1.json
  def update
    respond_to do |format|
      if @direction.update(direction_params)
        format.html { redirect_to @direction, notice: 'Direction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /directions/1
  # DELETE /directions/1.json
  def destroy
    @direction.destroy
    respond_to do |format|
      format.html { redirect_to directions_url, notice: 'Direction was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direction
      @direction = Direction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direction_params
      params.require(:direction).permit(:title, :body, :information, :scenario_id)
    end
end
