class WantsController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user, :shallow => true

  # GET /wants
  # GET /wants.json
  def index
    @wants = @wants.all(card_name: params[:card_name]) unless params[:card_name].blank?
    @wants = @wants.all(:card_name => current_user.have_card_names) if params[:traders]
    @wants = @wants.page(params[:page]) unless params[:format] == 'forum'
    @wants = @wants.all(:order => [:value.desc,:card_name.asc])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wants }
      format.forum
    end
  end

  # GET /wants/1
  # GET /wants/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @want }
    end
  end

  # GET /wants/new
  # GET /wants/new.json
  def new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @want }
    end
  end

  # GET /wants/1/edit
  def edit

  end

  # POST /wants
  # POST /wants.json
  def create
    @want.user = current_user

    respond_to do |format|
      if @want.save
        format.html { redirect_to @want, notice: 'Want was successfully created.' }
        format.json { render json: @want, status: :created, location: @want }
      else
        format.html { render action: "new" }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wants/1
  # PUT /wants/1.json
  def update

    respond_to do |format|
      if @want.update(params[:want])
        format.html { redirect_to @want, notice: 'Want was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wants/1
  # DELETE /wants/1.json
  def destroy
    @want.destroy

    respond_to do |format|
      format.html { redirect_to user_wants_url(@want.user), notice: 'Successfully deleted.' }
      format.json { head :ok }
    end
  end
end
