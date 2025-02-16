class GameLogic::FinancialService
  def initialize(game)
    @game = game
  end

  def purchase_beer(quantity)
    total_cost = quantity * @game.beer_cost
    
    if total_cost > @game.credits
      return { success: false, message: "Insufficient credits. Need #{total_cost} credits but only have #{@game.credits}." }
    end

    @game.with_lock do
      @game.credits -= total_cost
      @game.beers_in_stock += quantity
      @game.save!
    end

    { 
      success: true, 
      message: "Purchased #{quantity} beers for #{total_cost} credits.",
      new_balance: @game.credits,
      new_stock: @game.beers_in_stock
    }
  end

  def sell_beer(quantity)
    if quantity > @game.beers_in_stock
      return { success: false, message: "Insufficient stock. Only have #{@game.beers_in_stock} beers." }
    end

    revenue = quantity * @game.beer_sell_price
    profit = revenue - (quantity * @game.beer_cost)

    @game.with_lock do
      @game.credits += revenue
      @game.beers_in_stock -= quantity
      @game.save!
    end

    {
      success: true,
      message: "Sold #{quantity} beers for #{revenue} credits (Profit: #{profit}).",
      new_balance: @game.credits,
      new_stock: @game.beers_in_stock,
      profit: profit
    }
  end

  def apply_financial_event(credits_change:, reason:)
    return { success: false, message: "Invalid credits change." } unless credits_change.is_a?(Numeric)

    @game.with_lock do
      @game.credits += credits_change
      @game.save!
    end

    {
      success: true,
      message: "#{reason} (Credits change: #{credits_change})",
      new_balance: @game.credits
    }
  end

  def current_financial_status
    {
      credits: @game.credits,
      beers_in_stock: @game.beers_in_stock,
      beer_cost: @game.beer_cost,
      beer_sell_price: @game.beer_sell_price,
      potential_stock_value: @game.beers_in_stock * @game.beer_sell_price,
      profit_per_beer: @game.beer_sell_price - @game.beer_cost
    }
  end

  def adjust_prices(new_cost: nil, new_sell_price: nil)
    return { success: false, message: "No price changes provided." } if new_cost.nil? && new_sell_price.nil?

    @game.with_lock do
      @game.beer_cost = new_cost if new_cost
      @game.beer_sell_price = new_sell_price if new_sell_price
      @game.save!
    end

    {
      success: true,
      message: "Prices updated.",
      new_cost: @game.beer_cost,
      new_sell_price: @game.beer_sell_price,
      profit_margin: @game.beer_sell_price - @game.beer_cost
    }
  end
end
