class GearsController < ApplicationController
  before_action :set_gear, only: [:show, :edit, :update, :destroy]

  # GET /gears
  # GET /gears.json
  def index
    @gears = Gear.all

     @hash = Gmaps4rails.build_markers(@gears) do |gear , marker|
    marker.lat gear.latitude
    marker.lng gear.longitude
    marker.infowindow gear.title
    end
  end

  # GET /gears/1
  # GET /gears/1.json
  def show
  end

  # GET /gears/new
  def new
    @gear = Gear.new
  end

  # GET /gears/1/edit
  def edit
  end

  # POST /gears
  # POST /gears.json
  def create
    @current_usinfo
    @usinfo=Usinfo.all
    @usinfo.each do |elt|
      if(elt.user.email==current_user.email)
        @current_usinfo=elt
    end
    end
    @gear = @current_usinfo.gears.new(gear_params)

    respond_to do |format|
      if @gear.save
        format.html { redirect_to @gear, notice: 'Gear was successfully created.' }
        format.json { render :show, status: :created, location: @gear }
      else
        format.html { render :new }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gears/1
  # PATCH/PUT /gears/1.json
  def update
    respond_to do |format|
      if @gear.update(gear_params)
        format.html { redirect_to @gear, notice: 'Gear was successfully updated.' }
        format.json { render :show, status: :ok, location: @gear }
      else
        format.html { render :edit }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gears/1
  # DELETE /gears/1.json
  def destroy
    @gear.destroy
    respond_to do |format|
      format.html { redirect_to gears_url, notice: 'Gear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gear
      @gear = Gear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gear_params
      params.require(:gear).permit(:title, :definitionkey, :usinfo_id, :latitude, :longitude, :address, :description)
    end
end
