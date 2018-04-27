class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_house, :delete_house]
  before_action :authenticate_user, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @houses = House.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to login_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user == current_user && @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy if @user == current_user
    reset_session
    redirect_to :root
  end

  def add_house
    if params[:house_id].present?
      @house = House.find(params[:house_id])
      @user.houses << @house unless @user.houses.include?(@house) || params[:house_code] != @house.code
    end
    redirect_to @user
  end

  def delete_house
    @house = House.find(params[:house_id])
    @user.houses.delete(@house)
    redirect_to @user
  end

  def authenticate_user
    redirect_to :root unless logged_in?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end
end
