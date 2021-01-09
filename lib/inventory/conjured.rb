class Conjured
  def self.build(sell_in)
    if sell_in < 0
      Expired.new
    else
      new
    end
  end

  # Expired conjured will degrade quality 4 times
  class Expired
    def update(quality)
      quality.degrade
      quality.degrade
      quality.degrade
      quality.degrade
    end
  end

  def update(quality)
    quality.degrade
    quality.degrade
  end
end
