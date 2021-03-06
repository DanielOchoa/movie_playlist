class Movie < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :mpaa_rating, :original, :rating, :rotting_id, :runtime, :synopsis, :thumb, :title, :year
  friendly_id :title, use: :slugged
  # validates :mpaa_rating, :presence => true
  # validates :rating, :presence => true
  validates :rotting_id, :presence => true
  # validates :runtime, :presence => true
  # validates :synopsis, :presence => true
  # validates :year, :presence => true
  validates :title, :presence => true

  def self.text_search(query)
    if query.present?
      #where("title @@ :q", q: query)
      # with texticle now...
      basic_search(query)
    else
      scoped
    end
  end

end
