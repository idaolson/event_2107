require './lib/item'

RSpec.describe Item do
  context "it's an item" do
    item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

    it "exists" do
      expect(item).to be_an(Item)
    end

    it "has attributes" do
      expect(item.name).to eq('Peach Pie (Slice)')
      expect(item.price).to eq("$3.75")
    end
  end
end
