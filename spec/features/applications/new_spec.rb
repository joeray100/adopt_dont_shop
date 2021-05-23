require 'rails_helper'

RSpec.describe 'New Application Page' do
  before :each do
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

    @pet1 = @shelter1.pets.create!(name: "Babushka", breed: "Corgi", age: 70)
    @pet2 = @shelter1.pets.create!(name: "Fifi", breed: "St. Bernard", age: 3)
    @pet3 = @shelter1.pets.create!(name: "Myrtle", breed: "Maine Coon", age: 11)

    @pet4 = @shelter2.pets.create!(name: "Skittles", breed: "Ragdoll", age: 9)
    @pet5 = @shelter2.pets.create!(name: "Vixen", breed: "Pointer", age: 2)
    @pet6 = @shelter2.pets.create!(name: "Dino", breed: "Toy Poodle", age: 14)

    @pet7 = @shelter3.pets.create!(name: "Buttercup", breed: "Sphynx", age: 6)
    @pet8 = @shelter3.pets.create!(name: "OJ", breed: "Bombay", age: 10)
    @pet9 = @shelter3.pets.create!(name: "Stewie", breed: "French Bulldog", age: 4)

    @application1 = Application.create!(name: "Sketchy Steve", address: "6107 Dudley Ct", city: "Winchester", state: "NC", zip: 51631, description: "wide open spaces", status: 0)
    @application2 = Application.create!(name: "Jill", address: "31 Columbus Dr", city: "Denver", state: "CO", zip: 62814, description: "animals LOVE me", status: 1)
    @application3 = Application.create!(name: "Thadious", address: "6 Pickle St", city: "york", state: "OH", zip: 51631, description: "I have food...sometimes", status: 0)
    @application4 = Application.create!(name: "Yattle", address: "1123 Tickle Ct", city: "Minster", state: "CO", zip: 36297, description: "woof", status: 3)
    @application5 = Application.create!(name: "Sarah", address: "92 Ball Dr", city: "Arvada", state: "CO", zip: 36419, description: "I have yarn and squeeky toys", status: 0)

    @application1.pets.push(@pet1, @pet3)
    @application2.pets.push(@pet2, @pet8, @pet7)
    @application3.pets.push(@pet4)
    @application4.pets.push(@pet5)
    @application5.pets.push(@pet6, @pet9)

    visit new_application_path
  end

  it 'can create a new application' do
    @new_application = Application.create(name: "Jack", address: "13 Chicken St", city: "Carroway", state: "CO", zip: 23695, description: "I'm responsible", status: 0)

    expect(current_path).to eq(new_application_path)

    expect(page).to have_field("Name")
    expect(page).to have_field("Address")
    expect(page).to have_field("City")
    expect(page).to have_select("State")
    expect(page).to have_field("Zip")
    expect(page).to have_field("Description")

    fill_in "Name", with: 'Jack'
    fill_in "Address", with: '13 Chicken St'
    fill_in "City", with: 'Carroway'
    select 'CO', from: 'State'
    fill_in "Zip", with: '23695'
    fill_in "Description", with: "I'm responsible"

    click_on "Submit"

    expect(current_path).to eq(application_path(@new_application.id + 1))

    expect(page).to have_content(@new_application.name)
    expect(page).to have_content(@new_application.address)
    expect(page).to have_content(@new_application.city)
    expect(page).to have_content(@new_application.state)
    expect(page).to have_content(@new_application.zip)
    expect(page).to have_content(@new_application.description)
    expect(page).to have_content(@new_application.status)
  end

  it "I get an error message when I try to submit an incompleted form" do
    expect(page).to_not have_content("ERROR: Missing required information!")

    click_on 'Submit'

    expect(page).to have_content("ERROR: Missing required information!")
  end
end
