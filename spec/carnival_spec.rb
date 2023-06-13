require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do 
  it 'exists w/ attributes' do 
    carnival = Carnival.new({ duration: 30 })

    expect(carnival).to be_a(Carnival)
    expect(carnival.duration).to eq(30)
    expect(carnival.rides).to eq([])
  end

  it 'can add rides' do 
    carnival = Carnival.new({ duration: 30 })

    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.rides).to eq([ride1, ride2, ride3])
  end

  it 'can tell its most popular ride' do 
    carnival = Carnival.new({ duration: 30 })

    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)


    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor4 = Visitor.new('Goobert', 64, '$15')
    
    visitor1.add_preference(:gentle)
    visitor1.add_preference(:thrilling) #Gentle and Thrilling 1

    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling) #Gentle and Thrilling 2 

    visitor3.add_preference(:thrilling) #Thrilling only 3 
    visitor4.add_preference(:thrilling) #Thrilling only 4


    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)
    ride1.board_rider(visitor4)

    ride2.board_rider(visitor1)
    ride2.board_rider(visitor2)
    ride2.board_rider(visitor3)
    ride2.board_rider(visitor4)

    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor4)

    expect(carnival.most_popular_ride).to eq(ride3)
    expect(carnival.most_profitable_ride).to eq(ride2)
  end
end