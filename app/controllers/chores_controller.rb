class ChoresController < ApplicationController
  before_action :set_house
  before_action :set_chore, except: [:create]
  before_action :authenticate_user

  # GET /chores
  # GET /chores.json
  def index
    @chores = Chore.all
  end

  # GET /chores/1
  # GET /chores/1.json
  def show
  end

  # GET /chores/new
  def new
    @chore = Chore.new
  end

  # GET /chores/1/edit
  def edit
  end

  # POST /chores
  # POST /chores.json
  def create
    @house.chores.create(chore_params)
    redirect_to "/houses/#{@house.id}"
  end

  # PATCH/PUT /chores/1
  # PATCH/PUT /chores/1.json
  def update
    if @chore.update(chore_params)
      redirect_to "/houses/#{@house.id}"
    else
      render :edit
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.json
  def destroy
    @chore.destroy
    redirect_to "/houses/#{@house.id}"
  end

  def authenticate_user
    redirect_to :root unless logged_in?
  end

  def complete
    @chore.update(completed: !@chore.completed)
    redirect_to "/houses/#{@house.id}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chore
      @chore = Chore.find(params[:id])
    end

    def set_house
      @house = House.find(params[:house_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chore_params
      params.require(:chore).permit(:house_id, :description, :completed)
    end
end
