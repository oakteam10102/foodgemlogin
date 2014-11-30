class SubscriptionsController < ApplicationController
  before_action :authenticate_customer!

  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']

  def edit
    @subscription = current_customer.subscription
    @lunches = @subscription.lunch
    @lunches = [] unless @lunches
    @dinners = @subscription.dinner
    @dinners = [] unless @dinners
    @address = current_customer.address
    @tracks = Track.all
    @main_tracks = Track.main_tracks
    @follow_a_friend_tracks = Track.follow_a_friend_tracks
    @preferences = Preference.where(subscription: @subscription)
    @days = DAYS
  end

  def update
    subscription = Subscription.find(params[:id])
    redirect_to root_url if subscription.customer != current_customer

    subscription.lunch = params[:lunch]
    subscription.dinner = params[:dinner]
    notes = params[:subscription][:extra_notes]
    lunch_time = params[:subscription][:lunch_time]
    # subscription.lunch_time = lunch_time
    # subscription.extra_notes = notes
    subscription.save

    subscription.update(subscription_params)
    
    @pref_track_names = params[:preferences] ? params[:preferences] : []
    @old_preferences = Preference.where(subscription: subscription)
    @deleted_preferences = Preference.none

    @olds_after_delete = @old_preferences.reject{|old| @pref_track_names.include?(old.track.name) == false}
    @old_preferences.each do |oldie|
      unless @pref_track_names.include?(oldie.track.name)
        oldie.destroy
      end
    end

    @pref_track_names.each do |name|    
      track = Track.find_by_name(name)
      Preference.create(subscription: subscription, track: track) unless @old_preferences.where(track: track).any?
    end


    new_allergen_ids = params[:allergen_ids]
    if new_allergen_ids
      new_allergen_ids.each do |newbie_id|
        Allergy.create(customer: subscription.customer, allergen_id: newbie_id)
      end
    end

    if params[:commit] == 'Save changes'
      redirect_to root_url
    else
      redirect_to edit_payment_url(subscription.customer, mode: 'signup')
    end
  end

  def update_area
    @address = current_customer.address
    if @address.update(address_params)
      render :text => 'address updated'
    else
      render :text =>  'address is not update'
    end
  end
  
  def update_day_lunch
    subscription = Subscription.find(params[:id])
    subscription.lunch = params[:lunch]
    if subscription.save
      render :text => 'updated lunch'
    else
      render :text =>  'not update lunch'
    end
  end
  
  def update_day_dinner
    subscription = Subscription.find(params[:id])
    subscription.dinner = params[:dinner]
    if subscription.save
      render :text => 'updated dinner'
    else
      render :text =>  'not update dinner'
    end
  end
  
  def update_preferences
  	subscription = Subscription.find(params[:id])
  	@pref_track_names = params[:preferences] ? params[:preferences] : []
    @old_preferences = Preference.where(subscription: subscription)
    @deleted_preferences = Preference.none
    @olds_after_delete = @old_preferences.reject{|old| @pref_track_names.include?(old.track.name) == false}
    @old_preferences.each do |oldie|
      unless @pref_track_names.include?(oldie.track.name)
        oldie.destroy
      end
    end
    @pref_track_names.each do |name|    
      track = Track.find_by_name(name)
      Preference.create(subscription: subscription, track: track) unless @old_preferences.where(track: track).any?
    end
    render :text => 'updated preferences'
  end 
    
  def payment
  	@address = current_customer.address
  end
  
  def preference_quiz
  end

  def follow_a_friend
    @subscription = Subscription.find(params["id"]) rescue nil
    # abort edit_subscription_path(@subscription).inspect
    @track=Track.find(params["track_id"]) rescue nil
  end

  def ratings    
  end

  private
    def preference_params
    end
    def subscription_params
      params.require(:subscription).permit(:lunch_time, :dinner_time, :extra_notes)
    end
	def address_params
      params.require(:address).permit(:first_name, :last_name, :street_address, :suite, :city, :state, :zip, :phone, :email)
    end
end
