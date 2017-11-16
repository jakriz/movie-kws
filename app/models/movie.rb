class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :keywords

  scope :with_gross_amount, -> { where("gross_amount IS NOT NULL") }
end
