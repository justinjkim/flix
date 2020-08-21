require "rails_helper"

describe "A review" do
  
  context "is valid" do
    it "if it has all the attributes" do
      user = User.create(user_attributes)
      movie = Movie.create(movie_attributes)

      review = movie.reviews.new(comment: "This should pass!", stars: 2, user: user)

      expect(review).to be_valid
    end
  end
  context "is invalid" do
    it "if it doesn't have any stars" do
      user = User.create(user_attributes)
      movie = Movie.create(movie_attributes)

      review = movie.reviews.new(comment: "This is a test!", stars: nil, user: user)
      review.save
  
      expect(review).to_not be_valid
    end

    it "if it doesn't have a comment" do
      user = User.create(user_attributes)
      movie = Movie.create(movie_attributes)

      review = movie.reviews.new(comment: nil, stars: 3, user: user)
      review.save
  
      expect(review).to_not be_valid
    end

    it "if it doesn't have an associated user" do
      movie = Movie.create(movie_attributes)

      review = movie.reviews.new(comment: "This was a great movie!", stars: 5)
      review.save
      
      expect(review).to_not be_valid
    end
  end
  
end
