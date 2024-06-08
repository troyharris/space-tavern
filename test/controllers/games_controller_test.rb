require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url, as: :json
    assert_response :success
  end

  test "should create game" do
    assert_difference("Game.count") do
      post games_url, params: { game: { beer_cost: @game.beer_cost, beer_sell_price: @game.beer_sell_price, beers_in_stock: @game.beers_in_stock, colony_prosperity: @game.colony_prosperity, credits: @game.credits, day: @game.day, description: @game.description, history: @game.history, name: @game.name, tavern_popularity: @game.tavern_popularity } }, as: :json
    end

    assert_response :created
  end

  test "should show game" do
    get game_url(@game), as: :json
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { beer_cost: @game.beer_cost, beer_sell_price: @game.beer_sell_price, beers_in_stock: @game.beers_in_stock, colony_prosperity: @game.colony_prosperity, credits: @game.credits, day: @game.day, description: @game.description, history: @game.history, name: @game.name, tavern_popularity: @game.tavern_popularity } }, as: :json
    assert_response :success
  end

  test "should destroy game" do
    assert_difference("Game.count", -1) do
      delete game_url(@game), as: :json
    end

    assert_response :no_content
  end
end
