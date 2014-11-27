ActiveAdmin.register Track do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name,:description,:image,:track_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :image
      f.input :track_type, :label => 'Track Type', :as => :select, :collection => options_for_select(['Main','Follow a Friend'])
      f.submit
    end
  end


end

