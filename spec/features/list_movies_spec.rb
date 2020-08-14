require "rails_helper"

describe "Viewing root page (movies)" do
  it "shows the movies" do
    movie1 = Movie.create(title: "Iron Man",
      rating: "PG-13",
      total_gross: 318412101.00,
      description: "Tony Stark builds an armored suit to fight the throes of evil",
      duration: "120 min",
      released_on: "2008-05-02")

    movie2 = Movie.create(title: "Superman",
      rating: "PG",
      total_gross: 134218018.00,
      description: "Clark Kent grows up to be the greatest super-hero",
      duration: "90 min",
      released_on: "1978-12-15")

    movie3 = Movie.create(title: "Spider-Man",
      rating: "PG-13",
      total_gross: 403706375.00,
      description: "Peter Parker gets bit by a genetically modified spider",
      duration: "110 min",
      released_on: "2002-05-03")

    visit movies_url # 'visit' is a capybara thing

    # 'page' is a capybara-provided object
    expect(page).to have_text(movie1.title)
    expect(page).to have_text(movie2.title)
    expect(page).to have_text(movie3.title)
  end

  it "displays movie attributes" do
    movie1 = Movie.create(title: "Iron Man",
      rating: "PG-13",
      total_gross: 318412101.00,
      description: "Tony Stark builds an armored suit to fight the throes of evil",
      duration: "120 min",
      released_on: "2008-05-02",
      director: "Jon Favreau")

      visit movies_url

      expect(page).to have_text(movie1.description[0..10])
      expect(page).to have_text(movie1.director)
  end
end
