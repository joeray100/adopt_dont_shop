require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do
  before :each do
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

    @application1 = Application.create!(name: "Sketchy Steve", address: "6107 Dudley Ct", city: "Winchester", state: "NC", zip: 51631, description: "wide open spaces", status: 1)
    @application2 = Application.create!(name: "Jill", address: "31 Columbus Dr", city: "Denver", state: "CO", zip: 62814, description: "animals LOVE me", status: 0)
    @application3 = Application.create!(name: "Thadious", address: "6 Pickle St", city: "york", state: "OH", zip: 51631, description: "I have food...sometimes", status: 2)
    @application4 = Application.create!(name: "Yattle", address: "1123 Tickle Ct", city: "Minster", state: "CO", zip: 36297, description: "woof", status: 3)
    @application5 = Application.create!(name: "Sarah", address: "92 Ball Dr", city: "Arvada", state: "CO", zip: 36419, description: "I have yarn and squeeky toys", status: 0)
    # pending apps
    @application1.pets.push(@pet1)
    # approved apps
    @application3.pets.push(@pet3)
    # rejected apps
    @application4.pets.push(@pet4)

    visit admin_application_path(@application1)
  end

  it 'I see only pets with pending applications' do
    within "#pet-pending-#{@pet1.id}" do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet1.age)
      expect(page).to have_content(@pet1.breed)
    end
  end

  it "I see a button to approve the application next to each pet" do
    within "#pet-pending-#{@pet1.id}" do
      expect(page).to have_button('Approve Application')
      expect(page).to have_button('Reject Application')
    end
  end

  it "when I click button to approve pet app, I then see on the same page the button is gone and next to the pet the status is now 'Approved'." do
    expect(current_path).to have_content(admin_application_path(@application1))

    within "#pet-pending-#{@pet1.id}" do
      expect(page).to have_button('Approve Application')
      expect(page).to have_content('Status = Pending')
      click_button 'Approve Application'
    end

    expect(current_path).to have_content(admin_application_path(@application1))

    within "#pet-approved-#{@pet1.id}" do
      expect(page).to_not have_button('Approve Application')
      expect(page).to have_content('Status = Approved')
    end
  end

  it "when I click button to reject pet app, I then see on the same page the button is gone and next to the pet the status is now 'Rejected'." do
    expect(current_path).to have_content(admin_application_path(@application1))

    within "#pet-pending-#{@pet1.id}" do
      expect(page).to have_button('Approve Application')
      expect(page).to have_content('Status = Pending')
      click_button 'Reject Application'
    end

    expect(current_path).to have_content(admin_application_path(@application1))

    within "#pet-rejected-#{@pet1.id}" do
      expect(page).to_not have_button('Reject Application')
      expect(page).to have_content('Status = Rejected')
    end
  end
end
