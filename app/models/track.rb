class Track < ActiveRecord::Base
  has_many :preferences

  def to_s
    name
  end

def self.main_tracks
	Track.where(:track_type => 'Main')
end

def self.follow_a_friend_tracks
	Track.where(:track_type => 'Follow a Friend')
end

end
