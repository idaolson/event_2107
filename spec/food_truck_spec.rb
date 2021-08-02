require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
  context "it's a food truck" do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    it "exists" do
      expect(item1).to be_an(Item)
      expect(item2).to be_an(Item)
      expect(food_truck).to be_a(FoodTruck)
    end

    it "has attributes" do
      expect(item2.name).to eq("Apple Pie (Slice)")
      expect(item2.price).to eq(2.50)
      expect(food_truck.name).to eq("Rocky Mountain Pies")
      expect(food_truck.inventory).to eq({})
    end

    it "can check stock" do
      expect(food_truck.check_stock(item1)).to eq(0)
    end

    it "can add stock to an item and add it to inventory" do
      food_truck.stock(item1, 30)
      expect(food_truck.inventory).to eq({item1 => 30})
      expect(food_truck.check_stock(item1)).to eq(30)
      food_truck.stock(item1, 25)
      food_truck.check_stock(item1, 55)
      food_truck.stock(item2, 12)
      expect(food_truck.inventory).to eq({item => 55, item2 => 12})
    end
  end
end
