require './lib/item'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
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
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      
      expect(@item1.bids).to eq(@attendee1 => 20, @attendee2 => 22)
    end
  end

  describe '#current_high_bid' do
    it 'returns the highest current bid for the item' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      
      expect(@item1.current_high_bid).to eq(22)
    end
  end
end