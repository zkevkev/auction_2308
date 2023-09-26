class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid)
    @bids[attendee] = bid
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
end