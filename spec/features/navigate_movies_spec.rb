require "rails_helper"

describe "Navigating movies" do
  it "allows navigation from the detail page to the listing page" do
    movie = Movie.create(title: "Iron Man",
      rating: "PG-13",
      total_gross: 318412101.00,
      description: "Tony Stark builds an armored suit to fight the throes of evil",
      duration: "120 min",
      released_on: "2008-05-02")

    visit movie_url(movie)

    # for some reason, I could only use xpath for clicking on an image_tag
    find(:xpath, "//a/img[@id='logo']/..").click
    
    puts page.first("#logo").inspect
    expect(current_path).to eq(root_path)
  end
end
