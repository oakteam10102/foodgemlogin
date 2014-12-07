class Management::DeliveredMealsController < ApplicationController 
  before_action :authenticate_admin_user!
  def create
    customer = Customer.find(params[:customer_id])
    d_meal = DeliveredMeal.new(d_meal_params)
    customer.delivered_meals << d_meal
    customer.save
    
    redirect_to management_customer_url(customer)
  end

  private
    def d_meal_params
      params.require(:delivered_meal).permit(:name, :delivery_date, :meal_type)
    end
end