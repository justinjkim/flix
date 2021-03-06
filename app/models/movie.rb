class Movie < ApplicationRecord

  before_save :set_slug # callback to set slug before object is saved into DB

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user # many to many relationship
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }

  validate :acceptable_image # note that "validate" doesn't have a trailing "s", this is to trigger a                validation method, NOT a column

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

  # you don't need "self" here in method name because we are reading the "slug" attribute, not writing it
  def to_param
    slug
  end

  private

  # must use "self", otherwise it creates a local variable
  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless main_image.attached?
    unless main_image.blob.byte_size <= 1.megabyte
      errors.add(:main_image, "is over 1MB")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end
end
