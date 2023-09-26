class Auction
  attr_reader :items
  
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    item_names = @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.select do |item|
      item.bids == {}
    end
  end

  def potential_revenue
    potential_revenue = 0
    @items.each do |item|
      potential_revenue += item.current_high_bid
    end
    potential_revenue
  end
end