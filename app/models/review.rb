class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

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
  scope :past_n_days, ->(days = 7) { where('created_at >= ?', days.days.ago) }
  # .days.ago is a ruby method to get the days ago
  # Ex:- scope :active, -> {where(:active => true)}
end
