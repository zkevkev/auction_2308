require 'date'

class Auction
  attr_reader :items, :date
  
  def initialize
    @items = []
    @date = Date.today.strftime("%d/%m/%Y")
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
        bidders[attendee][:budget] = attendee.budget
        bidders[attendee][:items] << item
      end
    end
    bidders
  end

  def close_auction
    items_sold = {}
    @items.each do |item|
      highest_bidder = item.bids.max_by do |attendee, bid|
        bid
      end

      if highest_bidder == nil
        items_sold[item] = 'Not Sold'
      else
        bidder_won = highest_bidder[0]
        bid = highest_bidder[1]

        if bidder_won.budget >= bid
          items_sold[item] = bidder_won
          bidder_won.budget -= bid
        else
          # need to somehow gather second highest bid here (maybe a helper?)
          # make above helper, run through check (or do recursively)
        end
      end
      item.close_bidding
    end
    items_sold
  end
end