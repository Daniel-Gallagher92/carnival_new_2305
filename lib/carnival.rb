class Carnival 
attr_reader :duration, :rides

  def initialize(carnival_info)
    @duration = carnival_info[:duration]
    @rides = []
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.rider_log.length
    end
  end

  def most_profitable_ride
    rides.max_by do |ride|
      ride.total_revenue
    end
  end
end