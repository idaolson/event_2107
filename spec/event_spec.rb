require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  context "it's an event" do
    event = Event.new("South Pearl Street Farmers Market")
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")

    it "exists" do
      expect(event).to be_an(Event)
    end

    it "has attributes" do
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])
    end

    it "adds food trucks" do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
    end

    it "returns an array of food truck names" do
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it "returns an array of food trucks that sell an item" do
      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end

    it "returns the potential revenue of a food truck" do
      expect(food_truck1.potential_revenue).to eq(148.75)
      expect(food_truck2.potential_revenue).to eq(345.00)
      expect(food_truck3.potential_revenue).to eq(243.75)
    end
  end

  context "event has some fancy new methods" do
    event = Event.new("South Pearl Street Farmers Market")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")

    xit "returns a total inventory of food sold" do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      food_truck3.stock(item3, 10)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      result = {
          item1 => {
            quantity: 100,
            food_trucks: [food_truck1, food_truck3]
          },
          item2 => {
            quantity: 7,
            food_trucks: [food_truck1]
          },
          item4 => {
            quantity: 50,
            food_trucks: [food_truck2]
          },
          item3 => {
            quantity: 35,
            food_trucks: [food_truck2, food_truck3]
          },
        }
      expect(event.total_inventory).to eq(result)
    end

    it "returns list of all food items names sorted alphabetically" do
      result = ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]
      expect(event.sorted_item_list).to eq(result)
    end

    it "returns an array of overstocked items" do
      expect(event.overstocked_items).to eq(item1)
    end
  end
end


# Add a method to your `Event` class called `sorted_item_list`
# that returns a list of names of all items the FoodTrucks have in stock,
# sorted alphabetically. This list should not include any duplicate items.
#
# Additionally, your `Event` class should have a method called
# `total_inventory` that reports the quantities of all items sold
# at the event. Specifically, it should return a hash with items
# as keys and hash as values - this sub-hash should have two key/value
# pairs: quantity pointing to total inventory for that item and food_trucks
#  pointing to an array of the food trucks that sell that item.
#
# You `Event` will also be able to identify `overstocked_items`.  An item
# is overstocked if it is sold by more than 1 food truck AND
# the total quantity is greater than 50.
