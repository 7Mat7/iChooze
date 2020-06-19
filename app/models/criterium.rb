class Criterium < ApplicationRecord
  PLATFORMS = ["nfx", "dnp", "itu", "ocs", "prv", "cpd"]
  PLATFORMS_FULL_NAME = ["netflix", "disneyplus", "itunes", "go.ocs", "amazon", "primevideo", "canalplus"]

  belongs_to :user

  before_validation :clean_empty_platforms

  private

  def clean_empty_platforms
    platforms.reject!(&:empty?)
  end
end
