require "rails_helper"

describe "A movie" do
  it "is a flop if the total gross is less than $225,000,000" do
    movie = Movie.new(total_gross: 40_000_000)
    expect(movie.flop?).to eq(true)
  end
end
