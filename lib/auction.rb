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

  def bidders
    bidder_names = []
    @items.each do |item|
      item.bids.each do |attendee, bid|
        bidder_names << attendee.name
      end
    end
    bidder_names.uniq
  end

  def bidder_info
    bidders = {}
    @items.each do |item|
      item.bids.each do |attendee, bid|
        bidders[attendee] ||= { budget: 0, items: [] }
        budget = attendee.budget.gsub('$', '').to_i
        bidders[attendee][:budget] = budget
        bidders[attendee][:items] << item
      end
    end
    bidders
  end
end