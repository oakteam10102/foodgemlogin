class Track < ActiveRecord::Base
  has_many :preferences

  def to_s
    name
  end
  
	def self.find_tracks(track_type)
		Track.where(:track_type => track_type)
	end

end
