class AgedBrie
  def self.build(sell_in)
    if sell_in < 0
      Expired.new
    else
      new
    end
  end

  # Expired aged brie increase twice in quality
  class Expired
    def update(quality)
      quality.increase
      quality.increase
    end
  end

  def update(quality)
    quality.increase
  end
end
