class HealthGoal < ActiveRecord::Base
	validates :name, presence: true
	
  has_many :customer_health_goals
  has_many :customers, through: :customer_health_goals

  def to_s
    name.capitalize
  end
end
