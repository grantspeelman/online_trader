
class HavesController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user, :shallow => true
  # GET /haves
  # GET /haves.json
  def index
#    @haves = Have.all
    @haves = @haves.all(card_name: params[:card_name]) unless params[:card_name].blank?
    @haves = @haves.all(:card_name => current_user.want_card_names) if params[:traders]
    if params[:card_name] || params[:traders]
      @haves = @haves.all(:order => :value.asc)
    else
      @haves = @haves.all(:order => :card_name.asc)
    end
    @haves = @haves.page(params[:page]) unless params[:format] == 'forum'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @haves }
      format.forum
    end
  end

  # GET /haves/1
  # GET /haves/1.json
  def show
#    @have = Have.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @have }
    end
  end

  # GET /haves/new
  # GET /haves/new.json
  def new
#    @have = Have.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @have }
    end
  end

  # GET /haves/1/edit
  def edit
#    @have = Have.find(params[:id])
  end

  # POST /haves
  # POST /haves.json
  def create
#    @have = Have.new(params[:have])

    respond_to do |format|
      if @have.save
        format.html { redirect_to @have, notice: 'Have was successfully created.' }
        format.json { render json: @have, status: :created, location: @have }
      else
        format.html { render action: "new" }
        format.json { render json: @have.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /haves/1
  # PUT /haves/1.json
  def update
#    @have = Have.find(params[:id])

    respond_to do |format|
      if @have.update(params[:have])
        format.html { redirect_to @have, notice: 'Have was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @have.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /haves/1
  # DELETE /haves/1.json
  def destroy
#    @have = Have.find(params[:id])
    @have.destroy

    respond_to do |format|
      format.html { redirect_to haves_url, notice: 'Successfully deleted.' }
      format.json { head :ok }
    end
  end
end

