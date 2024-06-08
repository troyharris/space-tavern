class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]

  # GET /games
  def index
    @games = Game.includes(:patrons, :events, :messages).all

    render json: @games, include: [:patrons, :events, :messages]
  end
  # GET /games/1
  def show
    render json: @game, include: [:patrons, :events, :messages]
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
    render json: game, include: [:patrons, :events, :messages]
  end

  def create_new_game
    game = Game.new(game_params)
    game.create_new_game
    render json: game, include: [:patrons, :events, :messages]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :description, :day, :history, :tavern_popularity, :colony_prosperity, :credits, :beer_cost, :beer_sell_price, :beers_in_stock)
    end
end
