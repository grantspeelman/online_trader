class HavesController < ApplicationController
  before_action :login_required

  # GET /haves
  # GET /haves.json
  def index
    #    @haves = Have.all
    authorise(Have)
    load_haves

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @haves }
    end
  end

  private

  helper_method :index_heading

  def index_heading
    if current_user == user
      'My haves'
    elsif user
      "#{user.name} haves"
    else
      'Everyones Haves'
    end
  end

  def user
    @user ||= User[params[:user_id]]
  end

  public

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
    @have = authorise Have.new(have_params)
    @have.user = current_user

    if @have.save_if_valid
      redirect_to @have, notice: 'Have was successfully created.'
    else
      render 'new', status: 400
    end
  end

  # PUT /haves/1
  # PUT /haves/1.json
  def update
    @have = authorise(load_have)
    @have.set(have_params)

    if @have.save_if_valid
      redirect_to @have, notice: 'Have was successfully updated.'
    else
      render 'edit', status: 400
    end
  end

  private

  def have_params
    params[:have] || {}
  end

  public

  # DELETE /haves/1
  # DELETE /haves/1.json
  def destroy
    @have = authorise(load_have)
    @have.destroy

    redirect_to(request.referrer || { action: :index },
                notice: 'Successfully deleted.')
  end

  private

  def load_haves
    @haves = Have
    @haves = @haves.where(user_id: params[:user_id]) if params[:user_id].present?
    @haves = @haves.where(name: params[:name]) unless params[:name].blank?
    @haves = @haves.order(:name).paginate(params[:page] || 1, 20)
  end

  def load_have
    Have.with_pk!(params[:id])
  end
end
