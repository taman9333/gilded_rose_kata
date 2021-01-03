class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if sulfuras?(item)
      elsif generic?(item)
        handle_generic(item)
      elsif aged_brie?(item)
        handle_aged_brie(item)
      elsif backstage_pass?(item)
        handle_backstage_pass(item)
      end
    end
  end

  private

  def decrease_quality(item)
    item.quality = item.quality - 1
  end

  def increase_quality(item)
    item.quality = item.quality + 1
  end

  def quality_less_than_50(item)
    item.quality < 50
  end

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

  def handle_backstage_pass(item)
    if quality_less_than_50(item)
      increase_quality(item)
      if item.sell_in < 11
        if quality_less_than_50(item)
          increase_quality(item)
        end
      end
      if item.sell_in < 6
        if quality_less_than_50(item)
          increase_quality(item)
        end
      end
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end

  def handle_generic(item)
    if item.quality > 0
      decrease_quality(item)
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      if item.quality > 0
        decrease_quality(item)
      end
    end
  end

  def handle_aged_brie(item)
    if quality_less_than_50(item)
      increase_quality(item)
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      if quality_less_than_50(item)
        increase_quality(item)
      end
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
