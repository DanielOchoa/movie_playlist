class Movie < ActiveRecord::Base
  attr_accessible :mpaa_rating, :original, :rating, :rotting_id, :runtime, :synopsis, :thumb, :title, :year

  validates :mpaa_rating, :presence => true
  validates :rating, :presence => true
  validates :rotting_id, :presence => true
  validates :runtime, :presence => true
  validates :synopsis, :presence => true
  validates :year, :presence => true
  validates :title, :presence => true

end
