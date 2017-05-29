class MakesController < ApplicationController
  before_action :set_make, only: [:show, :edit, :update, :destroy]

  # GET /makes
  # GET /makes.json
  def index
    @makes = Make.all
  end

  # GET /makes/1
  # GET /makes/1.json
  def show
  end

  def report
    @message="lol"
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
  loop do
    c.publish('test', 'Hello World')
    render text:"request to generate a report added to the queue"
    sleep 10
  end
end
end
    Thread.new do
      MQTT::Client.connect(conn_opts) do |c|
        # The block will be called when you messages arrive to the topic
        c.get('test') do |topic, message|
          puts "#{topic}: #{message}"
          render text:"request to generate a report added to the queue"
        end
      end
    end
  end

def connect
    ReportWorker.connr()
    render text:"request to generate a report added to the queue"
  end 

  def generate_report
    sleep 30
  end







  # GET /makes/new
  def new
    @make = Make.new
  end

  # GET /makes/1/edit
  def edit
  end

  # POST /makes
  # POST /makes.json
  def create
    @make = current_gear.makes.new(make_params)

    respond_to do |format|
      if @make.save
        format.html { redirect_to @make, notice: 'Make was successfully created.' }
        format.json { render :show, status: :created, location: @make }
      else
        format.html { render :new }
        format.json { render json: @make.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /makes/1
  # PATCH/PUT /makes/1.json
  def update
    respond_to do |format|
      if @make.update(make_params)
        format.html { redirect_to @make, notice: 'Make was successfully updated.' }
        format.json { render :show, status: :ok, location: @make }
      else
        format.html { render :edit }
        format.json { render json: @make.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /makes/1
  # DELETE /makes/1.json
  def destroy
    @make.destroy
    respond_to do |format|
      format.html { redirect_to makes_url, notice: 'Make was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_make
      @make = Make.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def make_params
      params.require(:make).permit(:property, :state, :gear_id, :update_date)
    end
end
