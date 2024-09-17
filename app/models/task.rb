class Task < ApplicationRecord
  validates :title, presence: true
  validates :title, length: {maximum:30}
  validate :validate_title_not_include_comma

  private

  def validate_title_not_include_comma
    errors.add(:title, "にカンマを含めることはできません") if title&.include?(",")
  end
end
