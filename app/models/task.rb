class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :title, length: {maximum:30}
  validate :validate_title_not_include_comma

scope :recent, -> { order(created_at: :desc)}
# Ex:- scope :active, -> {where(:active => true)}

  private

  def validate_title_not_include_comma
    errors.add(:title, "にカンマを含めることはできません") if title&.include?(",")
  end
end
