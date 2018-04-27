class HousesController < ApplicationController
  before_action :set_house, except: [:new, :create]
  before_action :authenticate_user

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @users = User.all
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    @user = User.find(current_user.id)
    @house.users << @user unless @house.users.include? @user

    respond_to do |format|
      if @house.save
        format.html { redirect_to @house, notice: 'House was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @house.users << @user unless @house.users.include? @user
    end
    redirect_to @house
  end

  def delete_user
    @user = User.find(params[:user_id])
    @house.users.delete(@user)
    redirect_to @user
  end

  def authenticate_user
    redirect_to :root unless logged_in?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def house_params
    params.require(:house).permit(:name)
  end
end
