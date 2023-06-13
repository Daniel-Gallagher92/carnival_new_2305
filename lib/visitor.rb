class Visitor 
attr_reader :name, :height, :spending_money, :preferences
attr_writer :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money[1..-1].to_i
    @preferences = []
  end

  # def spending_money
  #   @spending_money = @spending_money
  # end

  def add_preference(preference) 
    @preferences.push(preference)
  end

  #method to check if visitor is tall enough
  #accepts argument of required height 

  def tall_enough?(height_requirement)
    @height >= height_requirement
  end

  
end