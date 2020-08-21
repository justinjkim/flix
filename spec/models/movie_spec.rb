require "rails_helper"

describe "A movie" do
  it "is a flop if the total gross is less than $225,000,000" do
    # no need to initialize movie object with full set of attributes, since we're just testing 'flop?' method
    movie = Movie.new(total_gross: 40_000_000)
    expect(movie.flop?).to eq(true)
  end

  it "is NOT a flop if the total gross is greater than or equal to $225,000,000" do
    # no need to initialize movie object with full set of attributes, since we're just testing 'flop?' method
    movie = Movie.new(total_gross: 225_000_000)
    expect(movie.flop?).to eq(false)
  end
end
