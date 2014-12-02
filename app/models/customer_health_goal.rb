class CustomerHealthGoal < ActiveRecord::Base
	belongs_to :customer
  belongs_to :health_goal
end
