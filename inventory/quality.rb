class Quality
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def degrade
    @amount -= 1 if amount.positive?
  end

  def increase
    if amount < 50
      @amount += 1
    end
  end

  def reset
    @amount = 0
  end
end
