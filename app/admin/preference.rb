ActiveAdmin.register Preference do

  permit_params :subscription_id, :track_id

  index do
    selectable_column
    id_column
    column "Subscription", :sortable => :subscription_id do |preference|
      preference.subscription.customer
    end
    column "Track", :sortable => :track_id  do |preference|
      preference.track.name
    end

    column :created_at
    actions
  end

end
