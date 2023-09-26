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
end