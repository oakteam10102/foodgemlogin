ActiveAdmin.register Preference do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :subscription_id, :track_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column "Subscription" do |preference|
      preference.subscription.customer
    end
    column "Track" do |preference|
      preference.track.name
    end

    column :created_at
    actions
  end

end
