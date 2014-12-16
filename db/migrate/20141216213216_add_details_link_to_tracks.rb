class AddDetailsLinkToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :details_link, :string
  end
end
