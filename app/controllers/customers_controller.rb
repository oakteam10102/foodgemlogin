class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer

    @subscription = @customer.subscription
    @subscription = Subscription.create(customer: @customer) unless @subscription
    if @subscription
      @preferences = @subscription.preferences
      @lunches = @subscription.lunch
      @dinners = @subscription.dinner
      @extra_notes = @subscription.extra_notes
      @lunch_time = @subscription.lunch_time ? @subscription.lunch_time.strftime('%H:%M') : 'time unset'
      @dinner_time = @subscription.dinner_time ? @subscription.dinner_time.strftime('%H:%M') : 'time unset'
    end
    
    @allergens = @customer.allergens


    @address = @customer.address
    @address = Address.create(customer: @customer) unless @address
    @phone = @address.phone


  end

  def edit_allergies
    @customer = Customer.find(params[:id])
    redirect_to root_url if @customer != current_customer

    @allergens = Allergen.all
  end

  def update_allergies
    @customer = Customer.find(params[:id])
    redirect_to root_url if @customer != current_customer

    old_allergen_ids = @customer.allergen_ids
    new_allergen_ids = params[:allergen_ids]



    old_allergen_ids.each do |oldie_id|
      unless new_allergen_ids.include? oldie_id
        allergy = Allergy.where('customer_id = ? AND allergen_id = ?', @customer.id, oldie_id).destroy_all
      end
    end

    new_allergen_ids.each do |newbie_id|
      unless old_allergen_ids.include? newbie_id
        Allergy.create(customer: @customer, allergen_id: newbie_id)
      end
    end

    redirect_to root_url
  end

end
