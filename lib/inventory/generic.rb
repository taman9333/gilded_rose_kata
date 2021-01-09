class Generic
  def self.build(sell_in)
    if sell_in < 0
      Expired.new
    else
      new
    end
  end

  # Expired generic will degrade twice
  class Expired
    def update(quality)
      quality.degrade
      quality.degrade
    end
  end

  def update(quality)
    quality.degrade
  end
end
