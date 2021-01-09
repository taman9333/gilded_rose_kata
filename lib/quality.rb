class Quality
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def degrade
    @amount -= 1 if amount > 0
  end

  def increase
    @amount += 1 if amount < 50
  end

  def reset
    @amount = 0
  end
end
