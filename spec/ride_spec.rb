require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do 
  it 'exists w/ attributes' do 
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    
    expect(ride1).to be_a(Ride)
    expect(ride1.name).to eq("Carousel")
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
    expect(ride1.total_revenue).to eq(0)
  end

  it 'can board/log a rider' do 
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor3)

    expect(ride1.rider_log).to eq({visitor1 => 2, visitor2 => 1})

    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    visitor2.add_preference(:thrilling) #Gentle and Thrilling
    visitor3.add_preference(:thrilling) #Thrilling only

    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(ride3.rider_log).to eq({visitor3 => 1}) #visitor 2 is too short
  end

  it 'can collect money and show total revenue' do 
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor3) # too cool for carousel
    ride3.board_rider(visitor3) # too cool for carousel, I'm doing my own thing mom

    expect(visitor1.spending_money).to eq(8)
    expect(visitor2.spending_money).to eq(4)
    expect(visitor3.spending_money).to eq(13)
    expect(ride1.total_revenue).to eq(3)
    expect(ride3.rider_log).to eq({visitor3 => 1})
    expect(ride3.total_revenue).to eq(2)
  end
end