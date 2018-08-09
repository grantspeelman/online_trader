# frozen_string_literal: true

class WantsController < ApplicationController
  before_filter :login_required

  # GET /wants
  # GET /wants.json
  def index
    #    @wants = Want.all
    authorise(Want)
    load_wants

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wants }
    end
  end

  private

  helper_method :index_heading

  def index_heading
    if current_user == user
      'My wants'
    elsif user
      "#{user.name} wants"
    else
      'Everyones Wants'
    end
  end

  def user
    @user ||= User[params[:user_id]]
  end

  public

  # GET /wants/1
  # GET /wants/1.json
  def show
    @want = authorise(load_want)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @want }
    end
  end

  # GET /wants/new
  # GET /wants/new.json
  def new
    @want = authorise Want.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @want }
    end
  end

  # GET /wants/1/edit
  def edit
    @want = authorise(load_want)
  end

  # POST /wants
  # POST /wants.json
  def create
    @want = authorise Want.new(params[:want])
    @want.user = current_user

    respond_to do |format|
      if @want.save
        format.html { redirect_to @want, notice: 'Want was successfully created.' }
        format.json { render json: @want, status: :created, location: @want }
      else
        format.html { render action: 'new' }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wants/1
  # PUT /wants/1.json
  def update
    @want = authorise(load_want)

    respond_to do |format|
      if @want.update(params[:want])
        format.html { redirect_to @want, notice: 'Want was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wants/1
  # DELETE /wants/1.json
  def destroy
    @want = authorise(load_want)
    @want.destroy

    respond_to do |format|
      format.html { redirect_to(request.referrer || { action: :index }, notice: 'Successfully deleted.') }
      format.json { head :ok }
    end
  end

  private

  def load_wants
    @wants = Want
    @wants = @wants.where(user_id: params[:user_id]) if params[:user_id].present?
    @wants = @wants.where(name: params[:name]) unless params[:name].blank?
    @wants = @wants.order(:name).paginate(params[:page] || 1, 20)
  end

  def load_want
    Want.with_pk!(params[:id])
  end
end
