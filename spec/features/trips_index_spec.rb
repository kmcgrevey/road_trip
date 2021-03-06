require 'rails_helper'

RSpec.describe "When I visit a trips index page as a visitor", type: :feature do
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

    TripTraveler.create(trip_id: @trip1.id, traveler_id: @traveler1.id)
    TripTraveler.create(trip_id: @trip2.id, traveler_id: @traveler1.id)
    
    TripTraveler.create(trip_id: @trip3.id, traveler_id: @traveler2.id)
  end
  
  it "I see the titles of all my trips as links" do
    visit "traveler/#{@traveler1.id}/trips"
# save_and_open_page
    expect(page).to have_content("My Trips Index")
    expect(page).to have_link(@trip1.title)
    expect(page).to have_link(@trip2.title)
    expect(page).not_to have_link(@trip3.title)
  end
end