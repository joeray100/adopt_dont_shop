VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
PetApplication.destroy_all


@veterinary_office1 = VeterinaryOffice.create!(name: "Denver Pet Clinic", max_patient_capacity: 60, boarding_services: true)
@veterinary_office2 = VeterinaryOffice.create!(name: "Austin Pet Clinic", max_patient_capacity: 40, boarding_services: true)

@veterinarian1 = @veterinary_office1.veterinarians.create!(name: "Biggie Smalls", review_rating: 6, on_call: true)
@veterinarian2 = @veterinary_office1.veterinarians.create!(name: "Dr. Dolittle", review_rating: 10, on_call: true)
@veterinarian3 = @veterinary_office1.veterinarians.create!(name: "Dr. Who", review_rating: 3, on_call: false)

@veterinarian3 = @veterinary_office2.veterinarians.create!(name: "Wesley Snipes", review_rating: 5, on_call: true)
@veterinarian3 = @veterinary_office2.veterinarians.create!(name: "Jean Claude Van Damme", review_rating: 7, on_call: true)

@shelter1 = Shelter.create!(name: "Denver Animal Rescue", city: "Denver", rank: 7, foster_program: true)
@shelter2 = Shelter.create!(name: "What Animal Rescue", city: "Boston", rank: 4, foster_program: false)
@shelter3 = Shelter.create!(name: "Boss Animal Rescue", city: "Chicago", rank: 9, foster_program: true)

@pet1 = @shelter1.pets.create!(name: "Babushka", breed: "Corgi", age: 70, adoptable: true)
@pet2 = @shelter1.pets.create!(name: "Fifi", breed: "St. Bernard", age: 3, adoptable: true)
@pet3 = @shelter1.pets.create!(name: "Myrtle", breed: "Maine Coon", age: 11, adoptable: true)

@pet4 = @shelter2.pets.create!(name: "Skittles", breed: "Ragdoll", age: 9, adoptable: true)
@pet5 = @shelter2.pets.create!(name: "Vixen", breed: "Pointer", age: 2, adoptable: true)
@pet6 = @shelter2.pets.create!(name: "Dino", breed: "Toy Poodle", age: 14, adoptable: true)

@pet7 = @shelter3.pets.create!(name: "Buttercup", breed: "Sphynx", age: 6, adoptable: true)
@pet8 = @shelter3.pets.create!(name: "OJ", breed: "Bombay", age: 10, adoptable: true)
@pet9 = @shelter3.pets.create!(name: "Stewie", breed: "French Bulldog", age: 4, adoptable: true)
@pet10 = @shelter3.pets.create!(name: "Bow", breed: "Boston Terrier", age: 3, adoptable: true)

@application1 = Application.create!(name: "Sketchy Steve", address: "6107 Dudley Ct", city: "Winchester", state: "NC", zip: 51631)
@application2 = Application.create!(name: "Jill", address: "31 Columbus Dr", city: "Denver", state: "CO", zip: 62814)
@application3 = Application.create!(name: "Thadious", address: "6 Pickle St", city: "york", state: "OH", zip: 51631)
@application4 = Application.create!(name: "Yattle", address: "1123 Tickle Ct", city: "Minster", state: "CO", zip: 36297)
@application5 = Application.create!(name: "Sarah", address: "92 Ball Dr", city: "Arvada", state: "CO", zip: 36419)

@application5.pets.push(@pet7)
@application4.pets.push(@pet8)
