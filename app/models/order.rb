# code in silo (take a user action and code it completely)

class Order
  # getters / setters
  attr_reader :meal, :customer, :employee, :delivered
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
    @meal = attributes[:meal]
    @customer = attributes[:customer] # typo
    @employee = attributes[:employee]
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
