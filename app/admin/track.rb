ActiveAdmin.register Track do

  permit_params :name, :description, :image, :track_type, :details_url

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, :as => :text
      f.input :image
      f.input :track_type, :label => 'Track Type', :as => :select, :collection => options_for_select(['Main','Follow a Friend'], :selected => f.object.track_type)
      f.input :details_url
      f.submit
    end
  end


end

