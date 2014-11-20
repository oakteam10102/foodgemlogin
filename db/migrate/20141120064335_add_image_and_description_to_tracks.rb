class AddImageAndDescriptionToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :description, :string
    add_column :tracks, :image, :string
  end
end
