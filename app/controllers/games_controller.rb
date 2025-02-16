class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy advance_time]

  # GET /games
  def index
    @games = Game.includes(:patrons, :events, :messages).all

    # Add this debug line
    Rails.logger.debug "Games: #{@games.inspect}"

    respond_to do |format|
      format.html { render :index } 
      format.json { render json: @games.as_json(include: [:patrons, :events, :messages]) }
    end
  end

  # GET /games/1
  def show
    respond_to do |format|
      format.html { render :show } 
      format.json { render json: @game, include: [:patrons, :events, :messages] }
    end
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    if @game.save
      render json: { id: @game.id }, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy!
  end

  def advance_time
    game = Game.includes(:patrons, :events, :messages).find(params[:id])
    game.advance_time
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to game_path(@game) }
    end
  end

  def create_new_game
    game = Game.new(game_params)
    game.create_new_game
    render json: game, include: [:patrons, :events, :messages]
  end

  def buy_beer
    game = Game.find(params[:id])
    number = params[:number_of_beers].to_i
    result = GameLogic::FinancialService.new(game).purchase_beer(number)
    if result[:success]
      flash[:notice] = result[:message]
    else
      flash[:alert] = result[:message]
    end
    redirect_to game_path(game)
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :description, :day, :history, :tavern_popularity, :colony_prosperity, :credits, :beer_cost, :beer_sell_price, :beers_in_stock)
    end
end
