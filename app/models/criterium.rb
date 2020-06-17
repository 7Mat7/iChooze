class Criterium < ApplicationRecord
  belongs_to :user

  before_validation :clean_empty_platforms

  private

  def clean_empty_platforms
    platforms.reject!(&:empty?)
  end
end
