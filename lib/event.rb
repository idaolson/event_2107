class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    food_trucks.map do |truck|
      truck if truck.inventory.include?(item)
    end.compact
  end

  def sorted_item_list
    array = @food_trucks.flat_map do |truck|
      truck.inventory.map do |item|
        item.name
      end
    end
    array.sort.uniq
  end
>
  def total_inventory
    hash = {}
    @food_trucks.map do |truck|
      truck.inventory.map do |item, amount|
        hash[item] = {quantity: amount, food_trucks: [truck]}
      end
    end
  end

  def overstocked_items
    total_inventory.keys.map do |key|
      total_inventory[key][:quantity] > 50
    end
  end
end
