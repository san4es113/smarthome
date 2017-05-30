class UsinfosController < ApplicationController
  before_action :set_usinfo, only: [:show, :edit, :update, :destroy]

  # GET /usinfos
  # GET /usinfos.json
  def index
    @usinfos = Usinfo.all
  end

  # GET /usinfos/1
  # GET /usinfos/1.json
  def show
  end

 def profile
     @infos = Usinfo.all
        @myinfo
        @infos.each do |elt|
            if(elt.user.email==current_user.email)
              @myinfo=elt
        end
    end
  end



  # GET /usinfos/new
  def new
    @usinfo = Usinfo.new
  end

  # GET /usinfos/1/edit
  def edit
  end

  # POST /usinfos
  # POST /usinfos.json
  def create
    @usinfo = current_user.usinfos.new(usinfo_params)

    respond_to do |format|
      if @usinfo.save
        format.html { redirect_to @usinfo, notice: 'Usinfo was successfully created.' }
        format.json { render :show, status: :created, location: @usinfo }
      else
        format.html { render :new }
        format.json { render json: @usinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usinfos/1
  # PATCH/PUT /usinfos/1.json
  def update
    respond_to do |format|
      if @usinfo.update(usinfo_params)
        format.html { redirect_to @usinfo, notice: 'Usinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @usinfo }
      else
        format.html { render :edit }
        format.json { render json: @usinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usinfos/1
  # DELETE /usinfos/1.json
  def destroy
    @usinfo.destroy
    respond_to do |format|
      format.html { redirect_to usinfos_url, notice: 'Usinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usinfo
      @usinfo = Usinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usinfo_params
      params.require(:usinfo).permit(:username, :birthday, :user_id)
    end
end
