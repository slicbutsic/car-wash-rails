# db/seeds.rb

# Delete all existing data
User.destroy_all
VehicleType.destroy_all
Price.destroy_all
Booking.destroy_all
Service.destroy_all

# Create Users (one user for testing)
user = User.create!(
  first_name: "Lucas",
  last_name: "Siviglia",
  email: "siviglialucas@gmail.com",
  password: "password",
  password_confirmation: "password"
)

admin = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@gmail.com",
  password: "X7pL9z@kVq!2tB1",
  password_confirmation: "X7pL9z@kVq!2tB1",
)

# Create Services
super_wash = Service.create!(name: '#1 Super Wash (outside only)', description:'Hand wash, rinse and chamois dry, windows cleaned (outside only).', duration: 25)
inside_and_out = Service.create!(name: '#2 Inside & Out', description: 'Includes service #1 + interior vacuumed, dashboard and console wiped, windows cleaned inside and outside.', duration: 55)
mega_works = Service.create!(name: '#3 Mega Works', description: 'Includes service #2 + extra clean on the inside.', duration: 75)
outside_hand_polish = Service.create!(name: '#4 Outside Hand Polish', description: 'Includes service #1 + hand polish on the outside', duration: 60)
inside_and_out_hand_polish = Service.create!(name: '#5 Inside & Out + Hand Polish', description: 'Includes service #2 + hand polish on the outside.', duration: 90)
full_detail = Service.create!(name: '#6 Full Detail', description: 'Wash, vacuum, seats and carpets steam cleaned, leather cleaned, windows cleaned.', duration: 240)
leather_cleaning = Service.create!(name: '#7 Leather Cleaning', description: 'A thorough deep-cleaning service for leather surfaces, removing dirt, and conditioning the material to restore its softness and shine.', duration: 120)
machine_polish_cut_and_polish = Service.create!(name: '#8 Machine Polish Cut & Polish', description: 'Machine polishing service that removes surface imperfections, swirl marks, and oxidation, restoring your vehicle.', duration: 240)

# Create Vehicle Types
vehicle_types = [
  'Hatchback & Sedan',
  'Wagon & MidSize SUV',
  'Large SUV & UTE',
  'Extra Large SUV & Van'
]

vehicle_types.each { |type| VehicleType.create!(name: type) }

# Create Prices for each service and vehicle type
# Super Wash
Price.create!(service: super_wash, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 30.00)
Price.create!(service: super_wash, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 35.00)
Price.create!(service: super_wash, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 40.00)
Price.create!(service: super_wash, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 45.00)

# Inside/Out
Price.create!(service: inside_and_out, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 60.00)
Price.create!(service: inside_and_out, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 65.00)
Price.create!(service: inside_and_out, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 70.00)
Price.create!(service: inside_and_out, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 75.00)

# Mega Works
Price.create!(service: mega_works, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 100.00)
Price.create!(service: mega_works, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 110.00)
Price.create!(service: mega_works, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 120.00)
Price.create!(service: mega_works, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 139.00)

#  Outside hand polish
Price.create!(service: outside_hand_polish, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 100.00)
Price.create!(service: outside_hand_polish, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 110.00)
Price.create!(service: outside_hand_polish, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 120.00)
Price.create!(service: outside_hand_polish, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 130.00)

# Inside/Out + Hand Polish
Price.create!(service: inside_and_out_hand_polish, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 125.00)
Price.create!(service: inside_and_out_hand_polish, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 145.00)
Price.create!(service: inside_and_out_hand_polish, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 160.00)
Price.create!(service: inside_and_out_hand_polish, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 175.00)

# Full Detail
Price.create!(service: full_detail, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 300.00)
Price.create!(service: full_detail, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 350.00)
Price.create!(service: full_detail, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 400.00)
Price.create!(service: full_detail, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 450.00)

# Leather Cleaning
Price.create!(service: leather_cleaning, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 220.00)
Price.create!(service: leather_cleaning, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 240.00)
Price.create!(service: leather_cleaning, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 260.00)
Price.create!(service: leather_cleaning, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 260.00)

# Machine Polish Cut & Polish
Price.create!(service: machine_polish_cut_and_polish, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 400.00)
Price.create!(service: machine_polish_cut_and_polish, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 450.00)
Price.create!(service: machine_polish_cut_and_polish, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 500.00)
Price.create!(service: machine_polish_cut_and_polish, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 550.00)

puts "Seed data created successfully!"
