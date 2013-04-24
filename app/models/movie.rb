class Movie < ActiveRecord::Base
  attr_accessible :mpaa_rating, :original, :rating, :rotting_id, :runtime, :synopsis, :thumb, :title, :year
end
