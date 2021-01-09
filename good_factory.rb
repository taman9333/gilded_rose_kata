require_relative './inventory/aged_brie'
require_relative './inventory/backstage_pass'
require_relative './inventory/generic'
require_relative './inventory/conjured'

class GoodFactory
  def self.build(item)
    case item.name
    when 'Aged Brie'
      AgedBrie.build(item.sell_in)
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass.build(item.sell_in)
    when 'Conjured Mana Cake'
      Conjured.build(item.sell_in)
    else
      Generic.build(item.sell_in)
    end
  end
end
