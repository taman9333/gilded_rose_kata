module Inventory

  class Quality
    attr_reader :amount

    def initialize(amount)
      @amount = amount
    end

    def degrade
      if amount > 0
        @amount -= 1
      end
    end

    def increase
      if amount < 50
        @amount += 1
      end
    end
  end

  class Generic
    attr_reader :sell_in

    def initialize(quality, sell_in)
      @quality = Quality.new(quality)
      @sell_in = sell_in
    end

    def quality
      @quality.amount
    end

    def update
      @quality.degrade
      @sell_in -= 1
      if sell_in < 0
        @quality.degrade
      end
    end
  end

  class AgedBrie
    attr_reader :sell_in

    def initialize(quality, sell_in)
      @quality = Quality.new(quality)
      @sell_in = sell_in
    end

    def quality
      @quality.amount
    end

    def update
      @quality.increase
      @sell_in -= 1
      if sell_in < 0
        @quality.increase
      end
    end
  end

  class BackstagePass
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update
      if quality < 50
        @quality += 1
        if sell_in < 11
          if quality < 50
            @quality += 1
          end
        end
        if sell_in < 6
          if quality < 50
            @quality += 1
          end
        end
      end
      @sell_in -= 1
      if sell_in < 0
        @quality = quality - quality
      end
    end
  end

  class Sulfuras
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality = quality
      @sell_in = sell_in
    end

    def update
    end
  end

  def initialize(items)
    @items = items
  end
end

class GildedRose

  class GoodCategory
    def build_for(item)
      if sulfuras?(item)
        Inventory::Sulfuras.new(item.quality, item.sell_in)
      elsif generic?(item)
        Inventory::Generic.new(item.quality, item.sell_in)
      elsif aged_brie?(item)
        Inventory::AgedBrie.new(item.quality, item.sell_in)
      elsif backstage_pass?(item)
        Inventory::BackstagePass.new(item.quality, item.sell_in)
      end
    end

    private

    def aged_brie?(item)
      item.name == 'Aged Brie'
    end

    def backstage_pass?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert"
    end

    def sulfuras?(item)
      item.name == "Sulfuras, Hand of Ragnaros"
    end

    def generic?(item)
      !(sulfuras?(item) or backstage_pass?(item) or aged_brie?(item))
    end
  end

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      good = GoodCategory.new.build_for(item)
      good.update
      item.quality = good.quality
      item.sell_in = good.sell_in
    end
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
