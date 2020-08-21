def movie_attributes(overrides = {})
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    director: "Anthony Russo",
    duration: "120 min",
    released_on: "2008-05-02"
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: "Bob",
    email: "bob@example.com",
    username: "bobbyrocks",
    password: "blahblahblah"
  }
end
