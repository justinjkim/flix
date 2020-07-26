class Movie < ApplicationRecord

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user # many to many relationship
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }

  # scopes dynamically define the follow as class-level methods
  scope :released, -> { where("released_on < ?", Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc) }
  scope :recent, ->(max=5) { released.limit(max) }
  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc) }
  scope :flops, -> { released.where("total_gross < 22500000").order(total_gross: :asc) }

  def flop?
    total_gross < 225_000_000 ? true : false
  end

  def self.recently_added
    order("created_at desc").limit(3)
  end

  def average_stars
    reviews.average(:stars).to_s || 0.0
  end
end
