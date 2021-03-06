class Review < ApplicationRecord
  belongs_to :movie
  validates :name, presence: true
  validates :comment, length: { minimum: 4 }

  STARS = [1, 2, 3, 4, 5].freeze
  validates :stars, inclusion: {
    in: STARS,
    message: 'must be between 1 and 5'
  }
  # define the number of stars as percentage then look in the shared?template
  def stars_as_percent
    (stars / 5.0) * 100.0
  end
end
