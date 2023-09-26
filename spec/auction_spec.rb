require './lib/auction'
require './lib/attendee'
require './lib/item'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_an_instance_of(Auction)
    end

    it 'has attributes' do
      expect(@auction.items).to eq([])
      allow(@auction).to receive(:date).and_return('25/9/2023')
    end
  end

  describe '#add_item' do
    it 'adds an item to item array' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      
      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  describe '#item_names' do
    it 'returns an array of all available item names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#unpopular_items' do
    it 'returns items which have no bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item3.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee3, 50)
      
      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end
  end

  describe '#potential_revenue' do
    it 'returns the sum of the highest current bid for all items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item3.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee3, 50)
      
      expect(@auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'returns an arry of all bidder names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item3.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee3, 50)
      
      expect(@auction.bidders).to eq(['Megan', 'Bob', 'Mike'])
    end
  end

  describe '#bidder_info' do
    it 'returns a hash of attendees linked to a nested hash of budget and bidded items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item3.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee3, 50)
      
      expected = {
        @attendee1 => {budget: 50, items: [@item1]},
        @attendee2 => {budget: 75, items: [@item1, @item3]},
        @attendee3 => {budget: 100, items: [@item4]}
      }
      
      expect(@auction.bidder_info).to eq(expected)
    end
  end

  describe '#cose_auction' do
    it 'returns a hash with items linked to the attendee that had the highest bid' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 18)
      @item1.add_bid(@attendee2, 30)
      @item2.add_bid(@attendee1, 30)
      @item3.add_bid(@attendee2, 5)
      @item3.add_bid(@attendee3, 3)
      @item4.add_bid(@attendee3, 40)
      @item4.add_bid(@attendee1, 55)
      @item4.add_bid(@attendee2, 45)
      
      expected = {
        @item1 => @attendee2,
        @item2 => @attendee1,
        @item3 => @attendee3,
        @item4 => @attendee2,
        @item5 => 'Not Sold'
      }
      
      expect(@auction.close_auction).to eq(expected)
    end
  end
end