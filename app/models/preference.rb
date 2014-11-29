class Preference < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :track

  validate :has_at_least_one_subscriber
  validate :has_at_least_one_track

  private

  def has_at_least_one_subscriber
    errors[:base] << "Preference should have at least one subscriber" if subscription_id.blank?
  end

  def has_at_least_one_track
    errors[:base] << "Preference should have at least one track" if track_id.blank?
  end

end
