class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  require 'mqtt'
  require 'uri'

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
  end



  def report


    uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }


    
  end  
 





  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  # POST /states.json
  def create
    @state = current_user.states.new(state_params)

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
 uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }


    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @state }

        @current_state=@state.property

         @thread = Thread.new do
          MQTT::Client.connect(conn_opts) do |c|
            # publish a message to the topic 'test'
              c.publish(@state.gear, @state.property+':'+@state.set)
            end
             
            MQTT::Client.connect(conn_opts) do |c|
              c.get(@state.gear) do |topic, message|
                if @state.property==@current_state
                      @state.state = message.to_s.split(':')[1]
                      @state.save
                  end    
              end
            end
        end
        Thread.kill(@thread)
      else
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:property, :state, :set, :gear, :user_id)
    end
end
