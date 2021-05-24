require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications).dependent(:destroy) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_numericality_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should define_enum_for(:status)}
  end

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
    @pet10 = @shelter3.pets.create!(name: "Bow", breed: "Boston Terrier", age: 3, adoptable: true)

    @application1 = Application.create!(name: "Sketchy Steve", address: "6107 Dudley Ct", city: "Winchester", state: "NC", zip: 51631, description: "wide open spaces", status: 0)
    @application2 = Application.create!(name: "Jill", address: "31 Columbus Dr", city: "Denver", state: "CO", zip: 62814, description: "animals LOVE me", status: 1)
    @application3 = Application.create!(name: "Thadious", address: "6 Pickle St", city: "york", state: "OH", zip: 51631, description: "I have food...sometimes", status: 0)
    @application4 = Application.create!(name: "Yattle", address: "1123 Tickle Ct", city: "Minster", state: "CO", zip: 36297, description: "woof", status: 3)
    @application5 = Application.create!(name: "Sarah", address: "92 Ball Dr", city: "Arvada", state: "CO", zip: 36419, description: "I have yarn and squeeky toys", status: 0)
  end

  describe 'instance methods' do
    describe '#adopted_pets' do
      it "should add a pet or pets to an applicant" do
        expect(@application3.adopted_pets(@pet10)).to eq([@pet10])

        expect(@application3.adopted_pets(@pet10)).to_not eq([@pet4])
      end
    end

    describe '#pet_count' do
      it "should count how many pets an applicant has" do
        expect(@application3.pet_count).to eq(0)
      end
    end
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
end
