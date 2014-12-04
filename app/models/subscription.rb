class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :preferences


  serialize :lunch
  serialize :dinner

  def to_s
    customer.email rescue ""
  end

  def lunch_time_string
    lunch_time ? lunch_time.strftime('%H,%M') : "default time" 
  end

  def dinner_time_string
    dinner_time ? dinner_time.strftime('%H,%M') : "default time" 
  end
end
