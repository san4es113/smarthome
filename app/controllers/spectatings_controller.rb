class SpectatingsController < ApplicationController
  before_action :set_spectating, only: [:show, :edit, :update, :destroy]

  # GET /spectatings
  # GET /spectatings.json
  def index
    @spectatings = Spectating.all
     @hash = Gmaps4rails.build_markers(@spectatings) do |spec , marker|
        marker.lat spec.latitude
        marker.lng spec.longitude
        marker.infowindow spec.title
        end

      uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }
      Thread.new do
          MQTT::Client.connect(conn_opts) do |c|
            # publish a message to the topic 'test'
              c.publish("kkkk", "u")
            end
            end
      Thread.new do
            MQTT::Client.connect(conn_opts) do |c|
             c.get('rosa/faces/img64') do |topic, message|
               
                      @state = Spectating.new
                      @state.image = Base64.decode64(message)
                      @state.save
               end       
              end
           end





  end

  # GET /spectatings/1
  # GET /spectatings/1.json
  def show
  end

  # GET /spectatings/new
  def new
    @spectating = Spectating.new
  end

  # GET /spectatings/1/edit
  def edit
  end

  # POST /spectatings
  # POST /spectatings.json
  def create
 @current_usinfo
    @usinfo=Usinfo.all
    @usinfo.each do |elt|
      if(elt.user.email==current_user.email)
        @current_usinfo=elt
    end
    end
   
    @spectating = @current_usinfo.spectatings.new(spectating_params)

    respond_to do |format|
      if @spectating.save
        format.html { redirect_to @spectating, notice: 'Spectating was successfully created.' }
        format.json { render :show, status: :created, location: @spectating }
      else
        format.html { render :new }
        format.json { render json: @spectating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spectatings/1
  # PATCH/PUT /spectatings/1.json
  def update
    respond_to do |format|
      if @spectating.update(spectating_params)
        format.html { redirect_to @spectating, notice: 'Spectating was successfully updated.' }
        format.json { render :show, status: :ok, location: @spectating }
      else
        format.html { render :edit }
        format.json { render json: @spectating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spectatings/1
  # DELETE /spectatings/1.json
  def destroy
    @spectating.destroy
    respond_to do |format|
      format.html { redirect_to spectatings_url, notice: 'Spectating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spectating
      @spectating = Spectating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spectating_params
      params.require(:spectating).permit(:latitude, :longitude, :address, :title, :description, :content, :date)
    end
end
