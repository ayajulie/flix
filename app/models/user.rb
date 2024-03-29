class User < ApplicationRecord
  before_save :format_username

  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false) }
  # Ex:- scope :active, -> {where(:active => true)}

  private

  def format_username
    self.username = username.downcase
  end
end
