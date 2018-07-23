# frozen_string_literal: true

class HavesController < ApplicationController
  before_filter :login_required

  # GET /haves
  # GET /haves.json
  def index
    #    @haves = Have.all
    authorise(Have)
    @user = User.get(params[:user_id])
    load_haves

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @haves }
      format.forum
    end
  end

  # GET /haves/1
  # GET /haves/1.json
  def show
    @have = authorise(load_have)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @have }
    end
  end

  # GET /haves/new
  # GET /haves/new.json
  def new
    @have = authorise Have.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @have }
    end
  end

  # GET /haves/1/edit
  def edit
    @have = authorise(load_have)
  end

  # POST /haves
  # POST /haves.json
  def create
    @have = authorise Have.new(params[:have])
    @have.user = current_user

    respond_to do |format|
      if @have.save
        format.html { redirect_to @have, notice: 'Have was successfully created.' }
        format.json { render json: @have, status: :created, location: @have }
      else
        format.html { render action: 'new' }
        format.json { render json: @have.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /haves/1
  # PUT /haves/1.json
  def update
    @have = authorise(load_have)

    respond_to do |format|
      if @have.update(params[:have])
        format.html { redirect_to @have, notice: 'Have was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @have.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /haves/1
  # DELETE /haves/1.json
  def destroy
    @have = authorise(load_have)
    @have.destroy

    respond_to do |format|
      format.html { redirect_to(request.referrer || { action: :index }, notice: 'Successfully deleted.') }
      format.json { head :ok }
    end
  end

  private

  def load_haves
    @haves = Have
    @haves = @haves.all(user_id: params[:user_id]) if params[:user_id].present?
    @haves = @haves.all(card_name: params[:card_name]) unless params[:card_name].blank?
    @haves = @haves.all(card_name: current_user.want_card_names) if params[:traders]
    @haves = @haves.all(order: :card_name.asc)
    @haves = @haves.page(params[:page])
  end

  def load_have
    Have.get!(params[:id])
  end
end
