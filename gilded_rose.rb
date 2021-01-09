require_relative './inventory/quality'
require_relative './good_factory'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if sulfuras?(item)

      item.sell_in -= 1
      quality = Quality.new(item.quality)
      good = GoodFactory.build(item)
      good.update(quality)
      item.quality = quality.amount
    end
  end

  private

  def sulfuras?(item)
    item.name.eql?('Sulfuras, Hand of Ragnaros')
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
