class RenameDetailsLinkToDetailsUrl < ActiveRecord::Migration
  def change
    rename_column :tracks, :details_link, :details_url
  end
end
