class Visitor 
attr_reader :name, :height, :spending_money, :preferences
attr_writer :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money[1..-1].to_i
    @preferences = []
  end

  def add_preference(preference) 
    @preferences.push(preference)
  end

  def tall_enough?(height_requirement)
    @height >= height_requirement
  end
end