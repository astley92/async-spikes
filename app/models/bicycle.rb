class Bicycle < ApplicationRecord
  validates :wheel_size, :colour, :gear_amount, presence: true
  validates :colour, length: { maximum: 10 }
  validates :wheel_size, numericality: { less_than_or_equal_to: 20 }

  validate :single_word_colour
  validate :valid_wheel_gear_ratio

  def single_word_colour
    if colour.include?(" ")
      errors.add(:colour, "can only contain one word")
    end
  end

  def valid_wheel_gear_ratio
    if wheel_size && gear_amount && wheel_size < gear_amount
      errors.add(:wheel_size, "must be greater than or equal to gear_amount")
    end
  end
end
