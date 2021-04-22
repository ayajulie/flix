class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user # transforms users to an alias "fans"
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  RATINGS = %w[G PG PG-13 R NC-17].freeze

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
  validates :rating, inclusion: { in: RATINGS }

  def flop?
    total_gross.blank? || total_gross < 255_000_000
  end
  # Ex:- scope :active, -> {where(:active => true)}

  # def self.released
  #   where('released_on < ?', Time.now).order(released_on: :desc)
  # end
  # scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :released, -> { where('released_on < ?', Time.now).order(released_on: :desc) }
  # it's called a lambda

  scope :upcoming, -> { where('released_on > ?', Time.now).order(released_on: :asc) }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :hits, -> { released.where('total_gross >= 300000000').order(total_gross: :desc) }
  scope :flops, -> { released.where('total_gross < 225000000').order(total_gross: :asc) }
  scope :grossed_less_than, ->(amount) { where('total_gross < ?', amount) }
  scope :grossed_greater_than, ->(_amout) { where('total_gross >  ?', amount) }
  # Ex:- scope :active, -> {where(:active => true)}
  # Ex:- scope :active, -> {where(:active => true)}

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end
end
