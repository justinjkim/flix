class User < ApplicationRecord
  before_save :lowercase

  has_many :reviews, dependent: :destroy # establish one-many relationship with reviews
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  has_secure_password

  validates :name, presence: true

  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 10, allow_blank: true }

  validates :username, presence: true,
                       format: { with: /\A[A-Z0-9]+\z/i },
                       uniqueness: { case_sensitive: false }

  scope :by_name, -> { order(name) }
  scope :non_admin, -> { by_name.where(admin: false) }

  def to_param
    username
  end

  private

  def set_username
    self.username = username.parameterize
  end

  def lowercase
    self.username = username.downcase # must use "self" because we're writing to this object
    self.email = email.downcase
  end
end
