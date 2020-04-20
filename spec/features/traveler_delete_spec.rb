require 'rails_helper'

RSpec.describe "When I visit a trips show page as a visitor", type: :feature do
  before(:each) do
    @trip1 = Trip.create!(title: "Cheese Tour 2020",
                          dest_city: "Madison, WI",
                          milage: 1100)
    @trip2 = Trip.create!(title: "Who is America Anyway?",
                        dest_city: "Washington, DC",
                        milage: 300)
    @trip3 = Trip.create!(title: "The Big Apple",
                        dest_city: "New York City, NY",
                        milage: 850)

    @traveler1 = Traveler.create!(name: "Sally Sue", age: 25)
    @traveler2 = Traveler.create!(name: "Tommy Tom", age: 46)
    @traveler3 = Traveler.create!(name: "Bob", age: 50)

    TripTraveler.create(trip_id: @trip1.id, traveler_id: @traveler1.id)
    TripTraveler.create(trip_id: @trip1.id, traveler_id: @traveler2.id)
    
    TripTraveler.create(trip_id: @trip2.id, traveler_id: @traveler1.id)
    TripTraveler.create(trip_id: @trip2.id, traveler_id: @traveler3.id)
  end

  it "I see click button next to a travelers name to remove them from trip" do
    visit "/trips/#{@trip1.id}"

    expect(page).to have_content(@traveler1.name)
    expect(page).to have_content(@traveler2.name)

    within "#traveler-#{@traveler1.id}" do
      click_button "Remove Traveler"
    end


    expect(page).not_to have_content(@traveler1.name)
    expect(page).to have_content(@traveler2.name)
  
  end

end
