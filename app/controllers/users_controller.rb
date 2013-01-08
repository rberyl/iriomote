class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    @u = User.find_by_id(params[:id])
    if !@u
      not_found
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(params[:user])
      flash[:success] = "Your profile was updated."
      redirect_to :action=>'show'
    else
      render 'edit'
    end
  end
end
