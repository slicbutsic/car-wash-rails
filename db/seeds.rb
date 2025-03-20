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

# Create Services
basic_outside_wash = Service.create!(name: 'Basic Outside Wash', description:'A quick exterior wash of your car’s body, windows, wheels, and tire shine. Perfect for regular upkeep and maintenance, keeping your vehicle looking fresh.', duration: 25)
basic_inside_out_detailing = Service.create!(name: 'Basic Inside/Out Detailing', description: 'Includes an exterior wash and interior vacuuming, dusting, and wipe-downs. A complete clean for both inside and outside of your vehicle.', duration: 55)
mega_wash = Service.create!(name: 'Mega Wash', description: 'A deep exterior wash, tire and rim cleaning, plus a thorough wipe-down of all surfaces. The ultimate cleaning experience for a pristine appearance.', duration: 75)
full_detailing = Service.create!(name: 'Full Detailing', description: 'Complete exterior wash, waxing, interior deep cleaning, and upholstery treatment. A meticulous clean that leaves your car spotless inside and out.', duration: 150)

# Create Vehicle Types
vehicle_types = [
  'Hatchback & Sedan',
  'Wagon & MidSize SUV',
  'Large SUV & UTE',
  'Extra Large SUV & Van'
]

vehicle_types.each { |type| VehicleType.create!(name: type) }

# Create Prices for each service and vehicle type
# Basic Outside Wash
Price.create!(service: basic_outside_wash, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 30.00)
Price.create!(service: basic_outside_wash, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 40.00)
Price.create!(service: basic_outside_wash, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 45.00)
Price.create!(service: basic_outside_wash, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 55.00)

# Basic Inside/Out Detailing
Price.create!(service: basic_inside_out_detailing, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 60.00)
Price.create!(service: basic_inside_out_detailing, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 65.00)
Price.create!(service: basic_inside_out_detailing, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 70.00)
Price.create!(service: basic_inside_out_detailing, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 80.00)

# Mega Wash
Price.create!(service: mega_wash, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 100.00)
Price.create!(service: mega_wash, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 110.00)
Price.create!(service: mega_wash, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 120.00)
Price.create!(service: mega_wash, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 139.00)

# Full Detailing
Price.create!(service: full_detailing, vehicle_type: VehicleType.find_by(name: 'Hatchback & Sedan'), price: 300.00)
Price.create!(service: full_detailing, vehicle_type: VehicleType.find_by(name: 'Wagon & MidSize SUV'), price: 350.00)
Price.create!(service: full_detailing, vehicle_type: VehicleType.find_by(name: 'Large SUV & UTE'), price: 400.00)
Price.create!(service: full_detailing, vehicle_type: VehicleType.find_by(name: 'Extra Large SUV & Van'), price: 450.00)

puts "Seed data created successfully!"
