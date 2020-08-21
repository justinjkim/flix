require "rails_helper"

describe "Viewing movie" do
  it "shows the movie attributes" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
  end

  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 300_000_000.00))

    visit movie_url(movie)

    expect(page).to have_text("$300,000,000")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 33333.00))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end
end
