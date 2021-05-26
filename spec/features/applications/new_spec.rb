require 'rails_helper'

RSpec.describe 'New Application Page' do

  before :each do
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
