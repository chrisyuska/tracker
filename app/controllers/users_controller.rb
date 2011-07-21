class UsersController < ApplicationController 
  before_filter :authenticate_user!
  before_filter :verify_admin, :except => [:index]
  
  def index
    @users = User.all
  end

  #GET
  #users/:id
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  #GET
  def edit    
    @user = User.find(params[:id])
  end

  #POST
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_path, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    # Don't change password if it wasn't entered
    params[:user].delete_if {|k,v| (k == "password" or k == "password_confirmation") and v.blank? }

    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.update_attribute(:admin, params[:user][:admin])
        @user.update_attribute(:name, params[:user][:name])
        format.html { redirect_to(users_path, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, :notice => 'User was successfully deleted.'
  end

  private

  # Used to block people against certain actions if they are indeed not an admin
  #
  def verify_admin
    unless current_user.admin? or params[:id].to_i == current_user.id
      redirect_to users_path, :alert => 'You are unauthorized to do that.'
    end
  end
end
