class BackstagePass
  def self.build(sell_in)
    if sell_in < 0
      Expired.new
    elsif sell_in < 5
      LessThan5Days.new
    elsif sell_in < 10
      LessThan10Days.new
    else
      new
    end
  end

  # Expired backstage pass will reset quality to 0
  class Expired
    def update(quality)
      quality.reset
    end
  end

  # LessThan5Days trible increase quality
  class LessThan5Days
    def update(quality)
      quality.increase
      quality.increase
      quality.increase
    end
  end

  # LessThan10Days double increase quality
  class LessThan10Days
    def update(quality)
      quality.increase
      quality.increase
    end
  end

  def update(quality)
    quality.increase
  end
end
