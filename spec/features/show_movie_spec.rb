require "rails_helper"

describe "Viewing movie" do
  it "shows the movie attributes" do
    movie = Movie.create(title: "Iron Man",
      rating: "PG-13",
      total_gross: 318412101.00,
      description: "Tony Stark builds an armored suit to fight the throes of evil",
      duration: "120 min",
      released_on: "2008-05-02")

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
  end
end
