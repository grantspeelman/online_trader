# frozen_string_literal: true

class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  def search
    load_card_names
    respond_to do |format|
      format.json { render json: @card_names.uniq }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: 'new' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :ok }
    end
  end

  private

  def load_card_names
    @card_names = Card.where(name: /^#{sanitize_term}/i).limit(20).distinct(:name)
    _load_more_from_cards
    _load_more_from_haves
    _load_more_from_wants
  end

  def _requires_more_card_names?
    @card_names.size < 20
  end

  def _load_more_from_wants
    return unless _requires_more_card_names?
    @card_names += Want.where(card_name: /#{sanitize_term}/i).limit(20 - @card_names.size).distinct(:card_name)
  end

  def _load_more_from_haves
    return unless _requires_more_card_names?
    @card_names += Have.where(card_name: /#{sanitize_term}/i).limit(20 - @card_names.size).distinct(:card_name)
  end

  def _load_more_from_cards
    return unless _requires_more_card_names?
    @card_names += Card.where(name: /#{sanitize_term}/i).limit(20 - @card_names.size).distinct(:name)
  end

  def sanitize_term
    @sanitize_term ||= params[:term].gsub(/\W/, '')
  end
end
