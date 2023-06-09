# frozen_string_literal: true

class Event < ApplicationRecord
  before_save :set_slug

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_one_attached :main_image

  validates :location, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  validate :acceptable_image

  scope :past, -> { where('starts_at < ?', Time.zone.now).order('starts_at') }
  scope :upcoming, -> { where('starts_at > ?', Time.zone.now).order('starts_at desc') }
  scope :free, -> { where(price: 0.0).order(:name) }
  scope :recent, ->(max = 3) { past.limit(max) }

  def free?
    price.blank? || price.zero?
  end

  def sold_out?
    (capacity - registrations.size).zero?
  end

  def to_param
    slug
  end

  private

  def acceptable_image
    return unless main_image.attached?

    errors.add(:main_image, 'is too big') unless main_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(main_image.content_type)

    errors.add(:main_image, 'must be a JPEG or PNG')
  end

  def set_slug
    self.slug = name.parameterize
  end
end
