require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  test 'has valid data' do
    track = tracks(:clara)
    track.valid?
  end
end
