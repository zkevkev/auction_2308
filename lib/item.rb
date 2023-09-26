class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
    @bidding_open = true
  end

  def add_bid(attendee, bid)
    if @bidding_open
      @bids[attendee] = bid
    else
      puts 'bidding is closed for this item'
    end
  end

  def current_high_bid
    high_bid = @bids.max_by do |attendee, bid|
      bid
    end
    if high_bid.nil?
      return 0
    else
      return high_bid[1]
    end
  end

  def close_bidding
    @bidding_open = false
  end
end