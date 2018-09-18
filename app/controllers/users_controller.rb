# frozen_string_literal: true

class UsersController < ApplicationController
  before_filter :login_required

  # GET /users
  # GET /users.json
  def index
    store_location
    authorise(User)
    @users = User.order(:created_at).paginate(params[:page] || 1, 20)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = authorise(load_user)
  end

  # GET /users/1/edit
  def edit
    @user = authorise(load_user)
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = authorise(load_user)

    if @user.update(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def load_user
    User.with_pk!(params[:id])
  end
end
