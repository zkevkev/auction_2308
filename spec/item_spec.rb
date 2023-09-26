require './lib/item'
require './lib/attendee'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      expect(@item1.name).to eq('Chalkware Piggy Bank')
      expect(@item1.bids).to eq({})
    end
  end

  describe '#add_bid' do
    it 'adds a bid to item bids hash' do
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      
      expect(@item1.bids).to eq({@attendee1 => 22, @attendee2 => 20})
    end
  end

  describe '#current_high_bid' do
    it 'returns the highest current bid for the item' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      
      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe '#close_bidding' do
    it 'disallows an item from recieving new bids' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      
      expect(@item1.close_bidding).to eq(false)

      @item1.close_bidding
      @item1.add_bid(@attendee2, 25)

      expect(@item1.bids).to eq({@attendee1 => 22, @attendee2 => 20})
    end
  end
end